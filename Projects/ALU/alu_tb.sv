// Self-Verifying Testbench for ALU


module ALU_tb;

  parameter N = 8;

  logic [N-1:0] A, B;
  logic [3:0] sel;
  logic cin;

  logic [N-1:0] Y;
  logic carry, zero, negative, overflow;

  logic [N:0] expected_sum_ext;
  logic [N-1:0] expected_Y;
  logic expected_carry;
  logic expected_zero, expected_negative, expected_overflow;

  integer pass_count = 0;
  integer fail_count = 0;

  ALU #(.N(N)) dut (
    .A(A), .B(B), .sel(sel), .cin(cin),
    .Y(Y), .carry(carry), .zero(zero),
    .negative(negative), .overflow(overflow)
  );

  task automatic check_result(
    input logic [N-1:0] test_A,
    input logic [N-1:0] test_B,
    input logic [3:0] test_sel,
    input logic test_cin,
    input logic [N-1:0] exp_Y,
    input logic exp_carry,
    input logic exp_zero,
    input logic exp_negative,
    input logic exp_overflow
  );
    begin
      A = test_A;
      B = test_B;
      sel = test_sel;
      cin = test_cin;

      #1;

      if ((Y !== exp_Y) ||
          (carry !== exp_carry) ||
          (zero !== exp_zero) ||
          (negative !== exp_negative) ||
          (overflow !== exp_overflow)) begin

        fail_count++;

        $display("FAIL: A=%0d B=%0d sel=%b cin=%b",
                 A, B, sel, cin);
        $display("Y expected=%0d actual=%0d",
                 exp_Y, Y);
        $display("Flags C/Z/N/V expected=%b%b%b%b actual=%b%b%b%b",
                 exp_carry, exp_zero, exp_negative, exp_overflow,
                 carry, zero, negative, overflow);
      end
      else begin
        pass_count++;
        $display("PASS: sel=%b A=%0d B=%0d Y=%0d",
                 sel, A, B, Y);
      end
    end
  endtask

  // Calculate and check one operation
  task automatic run_test(
    input logic [N-1:0] test_A,
    input logic [N-1:0] test_B,
    input logic [3:0] test_sel,
    input logic test_cin
  );
    logic [N:0] tmp_sum;
    logic [N-1:0] exp_Y;
    logic exp_carry, exp_zero, exp_negative, exp_overflow;

    begin
      tmp_sum = '0;
      exp_Y = '0;
      exp_carry = 0;
      exp_overflow = 0;

      case (test_sel)

        // ADD
        4'b0000: begin
          tmp_sum = {1'b0,test_A} + {1'b0,test_B} + test_cin;
          exp_Y = tmp_sum[N-1:0];
          exp_carry = tmp_sum[N];

          // Signed overflow, including carry-in
          exp_overflow =
              (test_A[N-1] == test_B[N-1]) &&
              (exp_Y[N-1] != test_A[N-1]);
          
        end

        // SUB: A - B - cin
        4'b0001: begin
          exp_Y = test_A - test_B - test_cin;
          exp_carry =
              ({1'b0,test_A} >= ({1'b0,test_B} + test_cin));
          exp_overflow =
              (test_A[N-1] != test_B[N-1]) &&
              (exp_Y[N-1] != test_A[N-1]);
        end

        // AND
        4'b0010: exp_Y = test_A & test_B;

        // OR
        4'b0011: exp_Y = test_A | test_B;

        // XOR
        4'b0100: exp_Y = test_A ^ test_B;

        // Bitwise NOT
        4'b0101: exp_Y = ~test_A;

        // Logical left shift
        4'b0110: exp_Y = test_A << 1;

        // Logical right shift
        4'b0111: exp_Y = test_A >> 1;

        // Arithmetic left shift (same bit movement as <<)
        4'b1000: exp_Y = test_A << 1;

        // Arithmetic right shift
        4'b1001: exp_Y = $signed(test_A) >>> 1;

        // Rotate left
        4'b1010: exp_Y = {test_A[N-2:0],test_A[N-1]};

        // Rotate right
        4'b1011: exp_Y = {test_A[0],test_A[N-1:1]};

        // Compare: greater -> bit 0, equal -> bit 1, less -> bit 2
        4'b1100: begin
          if (test_A > test_B)
            exp_Y[0] = 1'b1;
          else if (test_A == test_B)
            exp_Y[1] = 1'b1;
          else
            exp_Y[2] = 1'b1;
        end

        // Increment
        4'b1101: begin
          tmp_sum = {1'b0,test_A} + 1'b1;
          exp_Y = tmp_sum[N-1:0];
          exp_carry = tmp_sum[N];
        end

        // Decrement
        4'b1110: begin
          exp_Y = test_A - 1'b1;
          exp_carry = (test_A != '0);
        end

        // Arithmetic negation: two's complement
        4'b1111: exp_Y = -test_A;

      endcase

      exp_zero = (exp_Y == '0);
      exp_negative = exp_Y[N-1];

      check_result(
        test_A, test_B, test_sel, test_cin,
        exp_Y, exp_carry, exp_zero,
        exp_negative, exp_overflow
      );
    end
  endtask

  initial begin

    // One example for each opcode
    run_test(8'd5,   8'd3,   4'b0000, 0); // ADD: 5 + 3 = 8
    run_test(8'd9,   8'd4,   4'b0001, 0); // SUB: 9 - 4 = 5
    run_test(8'd12,  8'd10,  4'b0010, 0); // AND: 8
    run_test(8'd12,  8'd10,  4'b0011, 0); // OR: 14
    run_test(8'd12,  8'd10,  4'b0100, 0); // XOR: 6
    run_test(8'd15,  8'd0,   4'b0101, 0); // NOT: 240
    run_test(8'd3,   8'd0,   4'b0110, 0); // SLL: 6
    run_test(8'd8,   8'd0,   4'b0111, 0); // SRL: 4
    run_test(8'd64,  8'd0,   4'b1000, 0); // SLA: 128
    run_test(8'd128, 8'd0,   4'b1001, 0); // SRA: 192
    run_test(8'b10010001, 0, 4'b1010, 0); // ROL: 00100011
    run_test(8'b10010001, 0, 4'b1011, 0); // ROR: 11001000
    run_test(8'd9,   8'd4,   4'b1100, 0); // CMP: A > B
    run_test(8'd255, 8'd0,   4'b1101, 0); // INC: wraps to 0
    run_test(8'd0,   8'd0,   4'b1110, 0); // DEC: wraps to 255
    run_test(8'd5,   8'd0,   4'b1111, 0); // NEG: 251

    $display("");
    $display("========== TEST SUMMARY ==========");
    $display("Passed: %0d", pass_count);
    $display("Failed: %0d", fail_count);
    $display("Total : %0d", pass_count + fail_count);
    $display("==================================");

    $finish;
  end

endmodule
