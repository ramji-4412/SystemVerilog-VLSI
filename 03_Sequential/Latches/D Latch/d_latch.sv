module d_latch(
  input logic D,
  input logic E,
  output logic Q,
  output logic Qnot
);
  
  always_latch begin
    
    if(E) begin
      case(D)
        1'b0: begin
          Q <= 1'b0;
          Qnot <= ~Q;
        end
        1'b1: begin
          Q <= 1'b1;
          Qnot <= ~Q;
        end
        default: begin
          Q <= Q;
          Qnot <= ~Q;
        end
      endcase
    end
  end
endmodule
