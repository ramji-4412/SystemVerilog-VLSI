// Ripple 4-Bit Carry Adder - System Verilog

module full_adder(
  input logic a,
  input logic b,
  input logic c,
  output logic sum,
  output logic carry
);
  always_comb begin
    
    sum = a^b^c;
    carry = (a&b) | (b&c) | (c&a);
    
  end
endmodule

module RCA_4_bit( 
  input logic[3:0]A,
  input logic [3:0]B,
  input logic C,
  output logic [3:0]Sum,
  output logic Carry
);
  
  logic C1,C2,C3;
    
   full_adder F0(
      .a(A[0]),
      .b(B[0]),
      .c(C),
      .sum(Sum[0]),
      .carry(C1)
    );
    
    full_adder F1(
      .a(A[1]),
      .b(B[1]),
      .c(C1),
      .sum(Sum[1]),
      .carry(C2)
    );
    
    full_adder F2(
      .a(A[2]),
      .b(B[2]),
      .c(C2),
      .sum(Sum[2]),
      .carry(C3)
    );
    
    full_adder F3(
      .a(A[3]),
      .b(B[3]),
      .c(C3),
      .sum(Sum[3]),
      .carry(Carry)
    );
    
endmodule
