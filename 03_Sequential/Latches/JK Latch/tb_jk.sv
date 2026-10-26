module jk_latch_tb;
  logic J,K,E;
  logic Q,Qnot;
  
  int pass_count = 0;
  int fail_count = 0;
  
  jk_latch dut(.*);
  
  task automatic check_output(
    input logic e,
    input logic j,
    input logic k,
    input logic expected_q
  );
    
    begin
      E = e;
      J = j;
      K = k;
      
      #5;
      
      if((Q === expected_q) && (Qnot === ~expected_q)) begin
        $display("PASS: E=%b J=%b K=%b Q=%b Qnot=%b",E,J,K,Q,Qnot);
        pass_count++;
      end
      
      else begin
        $display("FAIL: E=%b J=%b K=%b Q=%b Qnot=%b",E,J,K,Q,Qnot);
        fail_count++;
      end
      
    end
  endtask
  
  initial begin
    
    $dumpfile("jk_latch.vcd");
    $dumpvars(1,jk_latch_tb);
    
    check_output(1'b1,1'b0,1'b1,1'b0); // en=1 j=0 k=1 qexp=0
    check_output(1'b0,1'b0,1'b1,1'b0); // en=0 j=0 k=1 qexp=0
    check_output(1'b1,1'b0,1'b0,1'b0); // en=1 j=0 k=0 qexp=0
    
    check_output(1'b1,1'b1,1'b0,1'b1); // en=1 j=1 k=0 qexp=1
    check_output(1'b0,1'b1,1'b0,1'b1); // en=0 j=1 k=0 qexp=1
    check_output(1'b1,1'b0,1'b0,1'b1); // en=1 j=0 k=0 qexp=1
    
    // The JK latch is level-sensitive. When Enable is high and J = K = 1, the toggle condition remains active. In my behavioral model, changing Q retriggers the always_latch block, which toggles Q again. This can create a zero-time oscillation, preventing simulation time from advancing. The underlying hardware issue is known as the race-around problem. A master-slave JK flip-flop or a suitable edge-triggered design avoids this behavior.
    
//     check_output(1'b1,1'b1,1'b1,1'b0); // en=1 j=1 k=1 qexp=0
//     check_output(1'b0,1'b1,1'b1,1'b0); // en=0 j=1 k=1 qexp=0
//     check_output(1'b1,1'b0,1'b0,1'b0); // en=1 j=0 k=0 qexp=0
   

    $display("------------------------------");
    $display("Total PASS = %0d", pass_count);
    $display("Total FAIL = %0d", fail_count);
    $display("------------------------------");

    if (fail_count == 0)
        $display("ALL TESTS PASSED!");
    else
        $display("SOME TESTS FAILED!");

    $finish;
  end
endmodule
