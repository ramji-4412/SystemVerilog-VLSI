// 4-bit Binary Multiplier - System Verilog

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

module half_adder(
  input logic a,
  input logic b,
  output logic sum,
  output logic carry
);
  
  always_comb begin
    
    sum = a^b;
    carry = (a&b);
    
  end
endmodule
  
module binary_multiplier(
  input logic [3:0]a,
  input logic [3:0]b,
  output logic [7:0]p
);
  
  logic [3:0]pp[3:0];
  
  always_comb begin
  
  	for(int i=0;i<4;i++)begin
    	for(int j=0;j<4;j++)begin
      	pp[i][j] = a[i]&b[j];
    	end
  	end
  end
  
  assign p[0] = pp[0][0];
  
  logic c1;
  
  half_adder H1(
    .a(pp[1][0]),
    .b(pp[0][1]),
    .sum(p[1]),
    .carry(c1)
  );
  
  logic sum1;
  logic carry1;
  logic c2;
  
  full_adder F1(
    .a(pp[2][0]),
    .b(pp[1][1]),
    .c(pp[0][2]),
    .sum(sum1),
    .carry(carry1)
  );
  
  half_adder H2(
    .a(sum1),
    .b(c1),
    .sum(p[2]),
    .carry(c2)
  );
  
  logic sum2;
  logic carry2;
  logic sum3;
  logic carry3;
  logic c3;
  
  full_adder F2(
    .a(pp[3][0]),
    .b(pp[2][1]),
    .c(pp[1][2]),
    .sum(sum2),
    .carry(carry2)
  );
  
  full_adder F3(
    .a(pp[0][3]),
    .b(carry1),
    .c(c2),
    .sum(sum3),
    .carry(carry3)
  );
  
  half_adder H3(
    .a(sum2),
    .b(sum3),
    .sum(p[3]),
    .carry(c3)
  );
  
  logic sum4;
  logic carry4;
  logic sum5;
  logic carry5;
  logic c4;
  
  full_adder F4(
    .a(pp[3][1]),
    .b(pp[2][2]),
    .c(pp[1][3]),
    .sum(sum4),
    .carry(carry4)
  );
  
  full_adder F5(
    .a(carry2),
    .b(carry3),
    .c(c3),
    .sum(sum5),
    .carry(carry5)
  );
  
  half_adder H4(
    .a(sum4),
    .b(sum5),
    .sum(p[4]),
    .carry(c4)
  );
  
  logic sum6;
  logic carry6;
  logic c5;
  logic sum7;
  logic carry7;
  
  full_adder F6(
    .a(pp[3][2]),
    .b(pp[2][3]),
    .c(carry4),
    .sum(sum6),
    .carry(carry6)
  );
  
  half_adder H5(
    .a(carry5),
    .b(c4),
    .sum(sum7),
    .carry(carry7)
  );
  
  half_adder H6(
    .a(sum6),
    .b(sum7),
    .sum(p[5]),
    .carry(c5)
  );
  
  logic sum8;
  logic carry8;
  logic sum9;
  logic carry9;
  logic c6;
  
  full_adder F7(
    .a(pp[3][3]),
    .b(carry6),
    .c(carry7),
    .sum(sum8),
    .carry(carry8)
  );
  
  half_adder H7(
    .a(sum8),
    .b(c5),
    .sum(p[6]),
    .carry(c6)
  );
  
  half_adder H8(
    .a(carry8),
    .b(c6),
    .sum(p[7]),
    .carry()
  );
endmodule
