// XNOR Gate - System Verilog

module xnor_gate(
  input logic a,
  input logic b,
  output logic y
);
  
  always_comb begin
    
    y = (~a)^b;   //y = (~a)*(~b) + (a*b);
    
  end
endmodule
