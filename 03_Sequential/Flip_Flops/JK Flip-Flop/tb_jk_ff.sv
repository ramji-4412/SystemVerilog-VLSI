module tb_jk_ff;
  logic J,K;
  logic clk;
  logic Q,Qnot;
  
  int pass_count = 0;
  int fail_count = 0;
  
  jk_ff dut(.*);
  
  task automatic check_output(
    input logic Qexpected
  );
    begin
      
      if((Q === Qexpected) && (Qnot === ~Qexpected)) begin
        $display("Time=%0t |	PASS:	J=%b | K=%b | Q=%b | Qnot=%b",$time,J,K,Q,Qnot);
        pass_count++;
      end
      
      else begin
        $display("Time=%0t |	FAIL:	J=%b | K=%b | Q=%b | Qnot=%b",$time,J,K,Q,Qnot);
        fail_count++;
      end
    end
  endtask
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  initial begin
    
    $dumpfile("jk_ff.vcd");
    $dumpvars(1,tb_jk_ff);
    
    J = 0;
    K = 0;
    #1;
    
    @(negedge clk);
    J = 0;
    K = 1;
    @(posedge clk);
    #1;
    check_output(1'b0);
    
    @(negedge clk);
    J = 0;
    K = 0;
    @(posedge clk);
    #1;
    check_output(1'b0);
    
    @(negedge clk);
    J = 1;
    K = 0;
    @(posedge clk);
    #1;
    check_output(1'b1);
    
    @(negedge clk);
    J = 0;
    K = 0;
    @(posedge clk);
    #1;
    check_output(1'b1);
    
    @(negedge clk);
    J = 1;
    K = 1;
    @(posedge clk);
    #1;
    check_output(1'b0);
    
    $display("\n========== SUMMARY ==========");
    $display("Passed: %0d", pass_count);
    $display("Failed: %0d", fail_count);
    if (fail_count != 0)
    	$fatal(1, "SR flip-flop verification failed");
	else
    	$display("All test cases passed successfully");

	$finish;
    
  end
endmodule
