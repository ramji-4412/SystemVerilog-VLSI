// Testbench for Parametrized ALU

module ALU_tb;

  parameter N = 16;

  logic [N-1:0] A, B;
  logic [3:0] sel;
  logic cin;

  logic [N-1:0] Y;
  logic carry, zero, negative, overflow;

  localparam longint unsigned MAX_TESTS = 64'd1000000;

  localparam longint unsigned PROGRESS_INTERVAL = 64'd100000;

  localparam bit EXHAUSTIVE_MODE = (N <= 8);

  // Wide counters for total combinations and test target.
  logic [127:0] total_tests;
  logic [127:0] target_tests;

  longint unsigned pass_count = 0;
  longint unsigned fail_count = 0;
  longint unsigned executed_count = 0;
  longint unsigned values_per_operand;

  real completion_pct;

  // DUT
  ALU #(.N(N)) dut (
    .A(A),
    .B(B),
    .sel(sel),
    .cin(cin),
    .Y(Y),
    .carry(carry),
    .zero(zero),
    .negative(negative),
    .overflow(overflow)
  );


  // Task 1: Compare actual outputs with expected outputs.
  task automatic check_result(
    input logic [N-1:0] test_A,
    input logic [N-1:0] test_B,
    input logic [3:0] test_sel,
    input logic test_cin,
    input logic [N-1:0] expected_Y,
    input logic expected_carry,
    input logic expected_zero,
    input logic expected_negative,
    input logic expected_overflow
  );
    begin
      A   = test_A;
      B   = test_B;
      sel = test_sel;
      cin = test_cin;

      #1;

      if ((Y !== expected_Y) ||
          (carry !== expected_carry) ||
          (zero !== expected_zero) ||
          (negative !== expected_negative) ||
          (overflow !== expected_overflow)) begin

        fail_count = fail_count + 1;

        $display(
          "FAIL: A=%h B=%h sel=%b cin=%b | Y=%h carry=%b zero=%b negative=%b overflow=%b | Expected Y=%h carry=%b zero=%b negative=%b overflow=%b",
          test_A, test_B, test_sel, test_cin,
          Y, carry, zero, negative, overflow,
          expected_Y, expected_carry, expected_zero,
          expected_negative, expected_overflow
        );

      end
      else begin
        pass_count = pass_count + 1;
      end

      executed_count = executed_count + 1;

      // Periodic progress checkpoints.
      if ((executed_count % PROGRESS_INTERVAL) == 0) begin

        completion_pct =
          (real'(executed_count) * 100.0) /
          real'(total_tests);

        $display("----------------------------------------");
        $display("Progress checkpoint");
        $display("Executed : %0d", executed_count);
        $display("Passed   : %0d", pass_count);
        $display("Failed   : %0d", fail_count);
        $display("Remaining: %0d", total_tests - executed_count);
        $display("Complete : %0.6f%%", completion_pct);
        $display("----------------------------------------");

      end
    end
  endtask


  // Task 2: Reference model.
  task automatic run_test(
    input logic [N-1:0] test_A,
    input logic [N-1:0] test_B,
    input logic [3:0] test_sel,
    input logic test_cin
  );

    logic [N:0] tmp_sum;
    logic [N-1:0] exp_Y;

    logic exp_carry;
    logic exp_zero;
    logic exp_negative;
    logic exp_overflow;

    logic signed [N:0] signed_A;
    logic signed [N:0] signed_B;
    logic signed [N:0] signed_result;

    begin
      tmp_sum = '0;
      exp_Y = '0;
      exp_carry = 1'b0;
      exp_overflow = 1'b0;

      signed_A = $signed({test_A[N-1], test_A});
      signed_B = $signed({test_B[N-1], test_B});
      signed_result = '0;

      case (test_sel)

        // ADD
        4'b0000: begin
          tmp_sum = {1'b0, test_A}
                  + {1'b0, test_B} + test_cin;

          exp_Y = tmp_sum[N-1:0];
          exp_carry = tmp_sum[N];

          signed_result = signed_A + signed_B + test_cin;
          exp_overflow =
            signed_result[N] != signed_result[N-1];
        end

        // SUB: A - B - cin
        4'b0001: begin
          tmp_sum = {1'b0, test_A}
                  - {1'b0, test_B} - test_cin;

          exp_Y = tmp_sum[N-1:0];

          // Carry = 1 means no unsigned borrow.
          exp_carry =
            ({1'b0, test_A} >=
             ({1'b0, test_B} + test_cin));

          signed_result = signed_A - signed_B - test_cin;
          exp_overflow =
            signed_result[N] != signed_result[N-1];
        end

        // AND
        4'b0010:
          exp_Y = test_A & test_B;

        // OR
        4'b0011:
          exp_Y = test_A | test_B;

        // XOR
        4'b0100:
          exp_Y = test_A ^ test_B;

        // NOT
        4'b0101:
          exp_Y = ~test_A;

        // Logical left shift
        4'b0110:
          exp_Y = test_A << 1;

        // Logical right shift
        4'b0111:
          exp_Y = test_A >> 1;

        // Arithmetic left shift
        4'b1000:
          exp_Y = test_A << 1;

        // Arithmetic right shift
        4'b1001:
          exp_Y = $signed(test_A) >>> 1;

        // Rotate left
        4'b1010:
          exp_Y = {test_A[N-2:0], test_A[N-1]};

        // Rotate right
        4'b1011:
          exp_Y = {test_A[0], test_A[N-1:1]};

        // Compare: greater -> bit 0,
        // equal -> bit 1, less -> bit 2.
        4'b1100: begin
  			if (N == 2) begin
    			if (test_A > test_B)
      				exp_Y = 2'b10;
    			else if (test_A == test_B)
      				exp_Y = 2'b01;
    			else
      				exp_Y = 2'b00;
  			end
  			else begin
    			if (test_A > test_B)
      				exp_Y[0] = 1'b1;
    			else if (test_A == test_B)
      				exp_Y[1] = 1'b1;
   				else
      				exp_Y[2] = 1'b1;
  			end
		end

        // Increment
        4'b1101: begin
          tmp_sum = {1'b0, test_A} + 1'b1;
          exp_Y = tmp_sum[N-1:0];
          exp_carry = tmp_sum[N];
        end

        // Decrement
        4'b1110: begin
          exp_Y = test_A - 1'b1;
          exp_carry = (test_A != '0);
        end

        // Two's-complement negation
        4'b1111:
          exp_Y = -test_A;

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


  // Main test sequence.
  initial begin

    // Compute counts using wide arithmetic.
    values_per_operand = 64'd1 << N;
    total_tests = 128'd1 << (2*N + 5);

    if (EXHAUSTIVE_MODE)
      target_tests = total_tests;
    else if (total_tests < MAX_TESTS)
      target_tests = total_tests;
    else
      target_tests = MAX_TESTS;

    $display("");
    $display("========== ALU VERIFICATION START ==========");
    $display("Width N             : %0d", N);
    $display("Mode                : %s", EXHAUSTIVE_MODE ? "EXHAUSTIVE" : "LIMITED");
    $display("Total possible tests: %0d", total_tests);
    $display("Target test count   : %0d", target_tests);
    $display("Progress interval   : %0d", PROGRESS_INTERVAL);
    $display("============================================");

    // A, B, opcode and cin are traversed systematically.
    // For N <= 8, all combinations are tested.
    // For N > 8, stop at target_tests.
    for (longint unsigned a = 0;
         a < values_per_operand &&
         executed_count < target_tests;
         a = a + 1) begin

      for (longint unsigned b = 0;
           b < values_per_operand &&
           executed_count < target_tests;
           b = b + 1) begin

        for (int op = 0;
             op < 16 &&
             executed_count < target_tests;
             op = op + 1) begin

          for (int c = 0;
               c < 2 &&
               executed_count < target_tests;
               c = c + 1) begin

            run_test(a, b, op, c);

          end
        end
      end
    end

    // Final summary.
    completion_pct =
      (real'(executed_count) * 100.0) /
      real'(total_tests);

    $display("");
    $display("========== FINAL ALU TEST SUMMARY ==========");
    $display("Width N             : %0d", N);
    $display("Total possible tests: %0d", total_tests);
    $display("Executed tests      : %0d", executed_count);
    $display("Passed tests        : %0d", pass_count);
    $display("Failed tests        : %0d", fail_count);
    $display("Tests remaining     : %0d",
             total_tests - executed_count);
    $display("Completion          : %0.6f%%", completion_pct);

    if (executed_count == total_tests) begin
      $display("Status              : COMPLETE");

      if (fail_count == 0)
        $display("Verification result : ALL TESTS PASSED");
      else
        $display("Verification result : FAILURES DETECTED");
    end
    else begin
      $display("Status              : PARTIAL");

      if (fail_count == 0)
        $display("Verification result : NO FAILURES IN EXECUTED TESTS");
      else
        $display("Verification result : FAILURES DETECTED");
    end

    $display("============================================");
    $finish;

  end

endmodule
