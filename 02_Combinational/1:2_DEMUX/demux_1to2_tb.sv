// 1:2 DEMUX Testbench - System Verilog

module demux1to2_tb;
  
  logic Y;
  logic S;
  logic I0;
  logic I1;
  
  demux1to2 dut(
    .Y(Y),
    .S(S),
    .I0(I0),
    .I1(I1)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,demux1to2_tb);
    
    $monitor("Y=%b | S=%b | I0=%b | I1=%b", Y,S,I0,I1);
    
    for(int i=0;i<4;i++) begin
      {Y,S} = i;
      #10;
    end
    
    $finish;
  end
endmodule
  
