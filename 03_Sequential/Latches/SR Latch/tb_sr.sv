// Testbench for SR Latch - System Verilog

module tb_sr;
  logic S,R;
  logic Q,Qbar;
  
  SR_latch dut(
    .S(S),
    .R(R),
    .Q(Q),
    .Qbar(Qbar)
  );
  
  task automatic check_output(
    input logic exp_Q,
    input logic exp_Qbar
  );
    
    begin
      #1;
      
      if(Q!==exp_Q || Qbar!==exp_Qbar) begin
        $display("FAIL: S=%b R=%b | Q=%b Qbar=%b | Expected Q=%b Qbar=%b",
                  S, R, Q, Qbar, exp_Q, exp_Qbar);
        $fatal(1, "Test failed!");
      end
      else begin
        $display("PASS: S=%b R=%b | Q=%b Qbar=%b | Expected Q=%b Qbar=%b",
                  S, R, Q, Qbar, exp_Q, exp_Qbar);
      end
    end
  endtask
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,tb_sr);
    
        $display("Starting SR latch self-checking testbench");

        // Establish a known state: Reset
        S = 1'b0;
        R = 1'b1;
        check_output(1'b0, 1'b1);

        // Test Set
        S = 1'b1;
        R = 1'b0;
        check_output(1'b1, 1'b0);

        // Test Hold after Set
        S = 1'b0;
        R = 1'b0;
        check_output(1'b1, 1'b0);

        // Test Reset
        S = 1'b0;
        R = 1'b1;
        check_output(1'b0, 1'b1);

        // Test Hold after Reset
        S = 1'b0;
        R = 1'b0;
        check_output(1'b0, 1'b1);
    
//     	// This test case must be failed 
//     	S = 1'b1;
//         R = 1'b1;
//     	check_output(1'b1, 1'b1);

        $display("All SR latch tests passed!");
        $finish;
    end
endmodule
