// 2:4 Decoder Testbench - System Verilog

module decoder2to4_tb;
  logic [1:0]I;
  logic Y0,Y1,Y2,Y3;
  
  decoder2to4 dut(
    .I(I),
    .Y0(Y0),
    .Y1(Y1),
    .Y2(Y2),
    .Y3(Y3)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,decoder2to4_tb);
    
    $monitor("I=%b | Y3 = %b | Y2 = %b | Y1 = %b | Y0 = %b",I,Y3,Y2,Y1,Y0);
    
    for(int i=0;i<4;i++)begin
      I = i;
      #10;
    end
    
    $finish;
  end
endmodule
