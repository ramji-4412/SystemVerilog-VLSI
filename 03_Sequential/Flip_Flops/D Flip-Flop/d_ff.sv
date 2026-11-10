module d_ff(
  input logic clk,
  input logic D,
  output logic Q,
  output logic Qnot
);
  
  always_ff @(posedge clk) begin
    Q <= D;
    Qnot <= ~D;
  end
endmodule
