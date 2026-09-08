// Half Adder - System Verilog

module half_adder(
  input logic a,
  input logic b,
  output logic sum,
  output logic carry
);
  
  always_comb begin
    
    sum = a^b;
    carry = a&b;
    
  end
endmodule
