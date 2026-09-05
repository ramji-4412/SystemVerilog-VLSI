// NOT Gate - System Verilog

module not_sv(
  input logic a,
  output logic y
);

  always_comb begin

    y = ~a;

  end
endmodule
