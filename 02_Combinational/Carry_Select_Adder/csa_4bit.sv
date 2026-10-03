# 4-bit CSA (Carry Select Order) - System Verilog

module full_adder(
  input logic a,
  input logic b,
  input logic cin,
  output logic cout,
  output logic sum
);
  
  always_comb begin
    
    sum = a^b^cin;
    cout = ((a&b) | (b&cin) | (cin&a)) ;
    
  end
endmodule

module RCA_2bit(
  input logic [1:0]a,
  input logic [1:0]b,
  input logic cin,
  output logic [1:0]sum,
  output logic cout
);
    
    logic c0;
    
    full_adder A0(
      .a(a[0]),
      .b(b[0]),
      .cin(cin),
      .sum(sum[0]),
      .cout(c0)
    );
    
    full_adder A1(
      .a(a[1]),
      .b(b[1]),
      .cin(c0),
      .sum(sum[1]),
      .cout(cout)
    );
  
endmodule

module csa_4bit(
  input logic [3:0]a,
  input logic [3:0]b,
  input logic cin,
  output logic [3:0]sum,
  output logic cout
);
    
    logic c0;
    
    logic [1:0] sum0, sum1;
    logic cout0, cout1;
    
    // Lower 2-bit RCA
    
    RCA_2bit lower(
      .a(a[1:0]),
      .b(b[1:0]),
      .cin(cin),
      .sum(sum[1:0]),
      .cout(c0)
    );
    
    // Upper 2-bit RCA assuming carry = 0
    
    RCA_2bit upper0(
      .a(a[3:2]),
      .b(b[3:2]),
      .cin(1'b0),
      .sum(sum0),
      .cout(cout0)
    );
    
    RCA_2bit upper1(
      .a(a[3:2]),
      .b(b[3:2]),
      .cin(1'b1),
      .sum(sum1),
      .cout(cout1)
    );
    
    assign sum[3:2] = c0 ? sum1 : sum0;
    assign cout = c0 ? cout1 : cout0;

endmodule  
