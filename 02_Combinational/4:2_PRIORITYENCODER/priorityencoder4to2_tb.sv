// 4:2 Priority Encoder Testbench - System Verilog

module priorityencoder4to2_tb;
  logic [3:0]I;
  logic [1:0]Y;
  
  priorityencoder4to2 dut(
    .I(I),
    .Y(Y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,priorityencoder4to2_tb);
    
    $monitor("I=%b | Y=%b", I,Y);
    
    for(int i=1;i<16;i++)begin
      I=i;
      #10;
    end
    
    $finish;
  end
endmodule
