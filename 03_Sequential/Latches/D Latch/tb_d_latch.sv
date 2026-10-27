module tb_d_latch;
  logic D;
  logic E;
  logic Q,Qnot;
  
  d_latch dut(.*);
  
  int pass_count = 0;
  int fail_count = 0;
  
  task automatic check_output(
    input logic e,
    input logic d,
    input logic expected_q
  );
    
    begin
      
      E = e;
      D = d;
      
      #5;
      
      if((Q === expected_q ) && (Qnot === ~expected_q)) begin
        $display("PASS: E=%b D=%b Q=%b Qnot=%b",E,D,Q,Qnot);
        pass_count++;
      end
      
      else begin
        $display("FAIL: E=%b D=%b Q=%b Qnot=%b",E,D,Q,Qnot);
        fail_count++;
      end
    end
  endtask
  
  initial begin
    
    $dumpfile("d_latch.vcd");
    $dumpvars(1,tb_d_latch);
    
    check_output(1'b1,1'b0,1'b0);
    check_output(1'b0,1'b0,1'b0);
    
    check_output(1'b1,1'b1,1'b1);
    check_output(1'b0,1'b1,1'b1);
    
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
