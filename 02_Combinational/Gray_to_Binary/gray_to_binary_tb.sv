// Gray to Binary Testbench - System Verilog

module graytobinary_tb;
  logic [3:0]B;
  logic [3:0]G;
  
  graytobinary dut(
    .B(B),
    .G(G)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,graytobinary_tb);
    
    $monitor("[ Gray Code = %b ] => [ Binary Code = %b ]", G,B);
    for(int i=0;i<16;i++)begin
      G=i;
      #20;
    end
    
    $finish;
  end
endmodule
