// 4-bit Carry Save Adder - System Verilog

module full_adder(
  input logic A,
  input logic B,
  input logic C,
  output logic Sum,
  output logic Cout
);
  
  always_comb begin
    
    Sum = A^B^C;
    Cout = (A&B) | (B&C) | (C&A);
    
  end
endmodule

module csa_4bit(
  input logic [3:0]A,
  input logic [3:0]B,
  input logic [3:0]C,
  output logic [4:0]Sum
);
  
  logic [3:0]S;
  logic [3:0]Cout;
  
  full_adder FA0(
    .A(A[0]),
    .B(B[0]),
    .C(C[0]),
    .Sum(S[0]),
    .Cout(Cout[0])
  );
  
  full_adder FA1(
    .A(A[1]),
    .B(B[1]),
    .C(C[1]),
    .Sum(S[1]),
    .Cout(Cout[1])
  );
  
  full_adder FA2(
    .A(A[2]),
    .B(B[2]),
    .C(C[2]),
    .Sum(S[2]),
    .Cout(Cout[2])
  );
  
  full_adder FA3(
    .A(A[3]),
    .B(B[3]),
    .C(C[3]),
    .Sum(S[3]),
    .Cout(Cout[3])
  );
  
  logic [4:0]Carry;
  
  assign Carry = {Cout,1'b0}; // Cout<<1;
  assign Sum = S + Carry;
  
endmodule
