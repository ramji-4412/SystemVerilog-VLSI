// Binary to Gray COnverter - System Verilog

module binarytogray(
  input logic [3:0]B,
  output logic [3:0]G
);
  
  always_comb begin
    
    G[3] = B[3];
    G[2] = B[3] ^ B[2];
    G[1] = B[2] ^ B[1];
    G[0] = B[1] ^ B[0];
    
  end
endmodule
