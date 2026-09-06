// NAND Gate - System Verilog

module nand_sv(
  input logic a,
  input logic b,
  output logic y
);
  
  always_comb begin
    
    y = ~(a&b);
    
  end
endmodule
