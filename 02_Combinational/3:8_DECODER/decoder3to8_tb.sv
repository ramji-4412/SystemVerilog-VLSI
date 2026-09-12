// 3:8 Decoder Testbench - System Verilog

module decoder3to8_tb;
  logic [2:0]I;
  logic [7:0]Y;
  
  decoder3to8 dut(
    .I(I),
    .Y(Y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,decoder3to8_tb);
    
    $monitor("I=%b | Y=%b",I,Y);
    
    for(int i=0;i<8;i++)begin
      I = i;
      #10;
    end
    
    $finish;
  end
endmodule
