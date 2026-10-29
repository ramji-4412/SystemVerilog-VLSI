module sr_ff(
  input logic S,
  input logic R,
  input logic Clk,
  output logic Q,
  output logic Qnot
);
  
  always_ff @(posedge Clk) begin
    
    case({S,R})
      2'b00: begin
        Q <= Q;
        Qnot <= ~Q;
      end
      2'b01: begin
        Q <= 1'b0;
        Qnot <= 1'b1;
      end
      2'b10: begin
        Q <= 1'b1;
        Qnot <= 1'b0;
      end
      2'b11: begin
        Q <= 1'bx;
        Qnot <= 1'bx;
      end
    endcase
  end
endmodule
