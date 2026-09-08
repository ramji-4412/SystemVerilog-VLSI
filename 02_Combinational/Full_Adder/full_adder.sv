// Full Adder - System Verilog

module full_adder(
  input logic a,
  input logic b,
  input logic c,
  output logic sum,
  output logic carry
);
  
  always_comb begin
    
    sum = a^b^c;
    carry = (a&b)|(b&c)|(c&a);
    
  end
endmodule
