// 2:1 MUX Testbench -  System Verilog

module mux2to1_tb;
  logic I0;
  logic I1;
  logic S;
  logic Y;
  
  mux2to1 dut(
    .I0(I0),
    .I1(I1),
    .S(S),
    .Y(Y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,mux2to1_tb);
    
    $monitor("I0=%b | I1=%b | S=%b | Y=%b",I0,I1,S,Y);
    
    for(int i=0;i<8;i++) begin
      {I0,I1,S} = i;
      #10;
    end
    
    $finish;
  end
endmodule
