// NOR Gate - System Verilog

module nor_gate(
  input logic a,
  input logic b,
  output logic y
);
  
 always_comba begin
   
   y = ~(a|b);
   
 end
endmodule
