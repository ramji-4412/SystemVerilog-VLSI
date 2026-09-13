// BCD to 7 Segment Testbench - System Verilog

module BCD_7segment_tb;
  logic [3:0]BCD;
  logic [6:0]SEG;
  
  BCD_7segment dut(
    .BCD(BCD),
    .SEG(SEG)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,BCD_7segment_tb);
    
    $monitor("BCD=%b | SEG=%b",BCD,SEG);
    
    for(int i=0;i<16;i++)begin
      BCD = i;
      #10;
      
    end
    $finish;
  end
endmodule
