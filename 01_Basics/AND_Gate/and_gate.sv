// And Gate - System Verilog

module and_sv(
  input logic a,
  input logic b,
  output logic y
);
  always_comb begin
    y = a & b;
  end
endmodule

