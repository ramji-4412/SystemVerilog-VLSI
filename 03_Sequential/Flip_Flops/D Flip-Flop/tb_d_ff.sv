module tb_d_ff;
  logic clk;
  logic D;
  logic Q,Qnot;
  
  int pass_count = 0;
  int fail_count = 0;
  
  d_ff dut(.*);
  
  task automatic check_output(
    input logic expected_q
  );
    begin
      if((Q === expected_q) && (Qnot === ~expected_q)) begin
        $display("Time=%0t  |  PASS: Clk=%b D=%b Q=%b Qnot=%b",$time,clk,D,Q,Qnot);
        pass_count++;
      end
      else begin
        $display("Time=%0t  |  FAIL: Clk=%b D=%b Q=%b Qnot=%b",$time,clk,D,Q,Qnot);
        fail_count++;
      end
    end
  endtask
    
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    
    $dumpfile("d_ff.vcd");
    $dumpvars(1,tb_d_ff);
    
    D = 0;
    @(posedge clk);
    #1;
    check_output(0);
    
    @(negedge clk);
    D = 1;
    #1;
    check_output(0);
    
    @(posedge clk);
    #1;
    check_output(1);
    
    @(negedge clk);
    D = 0;
    #1;
    check_output(1);
    
    @(posedge clk);
    #1;
    check_output(0);
    
    $display("--------------------------------");
    $display("PASS = %0d, FAIL = %0d",pass_count, fail_count);
    $display("--------------------------------");
	if (fail_count == 0)
      $display("ALL TESTS PASSED");
    else
      $display("SOME TESTS FAILED");

    $finish;
  end
endmodule
