// Carry Look Ahead Adder 4-Bit - System Verilog

module CLA_4_bit(
  input logic [3:0] A,
  input logic [3:0] B,
  input logic C,
  output logic [3:0] Sum,
  output logic Carry
);
  
  logic [3:0] P;
  logic [3:0] G;
  
  logic C1,C2,C3,C4;
  
  always_comb begin
  
  //Propagator
  P = A ^ B;
  
  //Generator
  G = A & B;
  
  //Carry Look Ahead 
  C1 = G[0] | (P[0]&C);
  C2 = G[1] | (P[1]&G[0]) | (P[1]&P[0]&C);
  C3 = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&C);
  C4 = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&C);
  
  Sum[0] = P[0]^C;
  Sum[1] = P[1]^C1;
  Sum[2] = P[2]^C2;
  Sum[3] = P[3]^C3;
  
  Carry = C4;
  
  end
endmodule
