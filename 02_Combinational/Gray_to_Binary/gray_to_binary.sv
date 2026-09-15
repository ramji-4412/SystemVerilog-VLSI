// Gray to Binary Code Converter - System Verilog

module graytobinary(
  input logic [3:0]G,
  output logic [3:0]B
);
  
  always_comb begin
    
    B[3] = G[3];
    B[2] = G[3] ^ G[2];
    B[1] = G[2] ^ G[1];
    B[0] = G[1] ^ G[0];
    
  end
endmodule
