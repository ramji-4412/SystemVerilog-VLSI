module encoder4to2_tb;
  logic [3:0]D;
  logic [1:0]Y;
  
  decoder4to2 dut(
    .D(D),
    .Y(Y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,decoder4to2_tb);
    
    $monitor("D=%b | Y=%b",D,Y);
    
    D=4'b0001;
    #10;
    D=4'b0010;
    #10;
    D=4'b0100;
    #10;
    D=4'b1000;
    #10
  
    $finish;
  end
endmodule
