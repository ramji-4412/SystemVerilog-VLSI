// 8:3 Encoder Testbench - System Verilog

module encoder8to3_tb;
  logic [7:0]I;
  logic [2:0]Y;
  
  encoder8to3 dut(
    .I(I),
    .Y(Y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,encoder8to3_tb);
    
    $monitor("I=%b | Y=%b",I,Y);
    
    for(int i=0;i<8;i++) begin
      I = 8'b0;
      I[i] = 1;
      #10;
    end
    
    $finish;
  end
endmodule
