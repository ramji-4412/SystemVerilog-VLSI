// Half Subtractor - System Verilog

module half_subtractor(
  input logic a,
  input logic b,
  output logic difference,
  output logic borrow
);
  
  always_comb begin
    
    difference = a^b;
    borrow = (~a)&b;
    
  end
endmodule
