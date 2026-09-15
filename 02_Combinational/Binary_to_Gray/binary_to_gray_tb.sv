// Binary to Gray Testbench - System Verilog

module binarytogray_tb;
  logic [3:0]B;
  logic [3:0]G;
  
  binarytogray dut(
    .B(B),
    .G(G)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,binarytogray_tb);
    
    $monitor("[ Binary Code = %b ] => [ Gray Code = %b ]",B,G);
    
    for(int i=0;i<16;i++)begin
      B=i;
      #10;
    end
    
    $finish;
  end
endmodule
