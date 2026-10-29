module tb_sr_ff;
  logic S,R;
  logic Clk;
  logic Q,Qnot;
  
  int pass_count = 0;
  int fail_count = 0;
  
  sr_ff dut(.*);
  
  task automatic check_output(
    input logic Qexpected
  );
    begin
      if((Q === Qexpected) && (Qnot === ~Qexpected))begin
        $display("Time=%0t |	PASS:	Clk=%b | S=%b | R=%b | Q=%b | Qnot=%b",$time,Clk,S,R,Q,Qnot);
        pass_count++;
      end
      else begin
        $display("Time=%0t |	FAIL:	Clk=%b | S=%b | R=%b | Q=%b | Qnot=%b",$time,Clk,S,R,Q,Qnot);
      	fail_count++;
      end
    end
  endtask
  
  initial Clk = 0;
  always #5 Clk = ~Clk;
  
  initial begin
    
    $dumpfile("sr_ff.vcd");
    $dumpvars(1,tb_sr_ff);
    
    S=0;
    R=0;
    #1;
    
    @(negedge Clk);
    S=0;
    R=1;
    @(posedge Clk);
    #1;
    check_output(1'b0);
    
    @(negedge Clk);
    S=0;
    R=0;
    @(posedge Clk);
    #1;
    check_output(1'b0);
    
    @(negedge Clk);
    S=1;
    R=0;
    @(posedge Clk);
    #1;
    check_output(1'b1);
    
    @(negedge Clk);
    S=0;
    R=0;
    @(posedge Clk);
    #1;
    check_output(1'b1);
    
    @(negedge Clk);
    S=1;
    R=1;
    @(posedge Clk);
    #1;
    if((Q === 1'bx) && (Qnot === 1'bx)) begin
      $display("PASS: Invalid condition | Clk=%b | S=%b | R=%b | Q=X | Qnot=X",Clk,S,R);
      pass_count++;
    end
    else begin
      $display("FAIL: Invalid condition | Clk=%b | S=%b | R=%b | Expected_Q=X | Got_Q=%b",Clk,S,R,Q);
      fail_count++;
    end
    
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
