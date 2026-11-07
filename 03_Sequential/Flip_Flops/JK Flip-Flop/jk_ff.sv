module jk_ff(
  input logic J,
  input logic K,
  input logic clk,
  output logic Q,
  output logic Qnot
);
  
  always_ff @(posedge clk) begin
    case({J,K})
      2'b00: Q <= Q;
      2'b01: Q <= 1'b0;
      2'b10: Q <= 1'b1;
      2'b11: Q <= ~Q;
    endcase
  end
  
  assign Qnot = ~Q;
endmodule
