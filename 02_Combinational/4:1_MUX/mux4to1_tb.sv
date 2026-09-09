// 4:1 MUX Testbench - System Verilog

module mux4to1_tb;
  logic I0,I1,I2,I3;
  logic [1:0]S;
  logic Y;
  
  mux4to1 dut(
    .I0(I0),
    .I1(I1),
    .I2(I2),
    .I3(I3),
    .S(S),
    .Y(Y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,mux4to1_tb);
    
    $monitor("I0=%b | I1=%b | I2=%b | I3=%b | S=%b | Y=%b",I0,I1,I2,I3,S,Y);
    
    for(int i=0;i<64;i++) begin
      {I0,I1,I2,I3,S} = i;
      #10;
    end
    
    $finish;
  end
endmodule
