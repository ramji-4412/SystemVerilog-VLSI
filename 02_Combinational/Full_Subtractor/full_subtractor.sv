// Full Subtractor - System Verilog

module full_subtractor(
  input logic a,
  input logic b,
  input logic c,
  output logic difference,
  output logic borrow
);
  
  always_comb begin
    
    difference = a^b^c;
    borrow = (~a&b) | (b&c) | (~a&c);
    
  end
endmodule
