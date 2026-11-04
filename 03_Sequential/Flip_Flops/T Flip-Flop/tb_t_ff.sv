module tb_t_ff;
  logic T;
  logic clk;
  logic rst_n;
  logic Q,Qnot;
  
  int pass_count = 0;
  int fail_count = 0;
  
  t_ff dut(.*);
  
  task automatic check_output(
    input logic Qexpected
  );
    
    begin
      
      if((Q === Qexpected) && (Qnot === ~Qexpected)) begin
        $display("Time=%0t |	PASS: Clk=%b T=%b Q=%b Qnot=%b",$time,clk,T,Q,Qnot);
        pass_count++;
      end
      else begin
        $display("Time=%0t |	FAIL: Clk=%b T=%b Q=%b Qnot=%b",$time,clk,T,Q,Qnot);
        fail_count++;
      end
    end
  endtask
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    
    $dumpfile("t.vcd");
    $dumpvars(1,tb_t_ff);
   
    T = 0;
    rst_n = 1;
    
    #1;
    rst_n = 0;
    repeat(2) @(negedge clk);
    rst_n = 1;
    
    @(negedge clk);
    T = 1;
    
    @(posedge clk);
    #1;
    check_output(1'b1);
    
    @(negedge clk);
    T = 0;
    
    @(posedge clk);
    #1;
    check_output(1'b1);
    
    @(negedge clk);
    T = 1;
    
    @(posedge clk);
    #1;
    check_output(1'b0);
    
    @(negedge clk);
    T = 0;
    
    @(posedge clk);
    #1;
    check_output(1'b0);
    

    $display("-------------------------");
    $display("Total PASS = %0d", pass_count);
    $display("Total FAIL = %0d", fail_count);

    if (fail_count == 0)
      $display("ALL TESTS PASSED!");
    else
      $fatal(1, "Some tests failed!");

    $finish;
  end
endmodule
