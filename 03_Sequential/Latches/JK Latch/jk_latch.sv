module jk_latch(
  input logic J,
  input logic K,
  input logic E,
  output logic Q,
  output logic Qnot
);
  
  always_latch begin
    
    if(E) begin
      case({J,K})
        2'b00: begin    //while using always_latch, if we make a case empty then it means it will consider previous value or hold operation will be ocurred. Hold: no assignment
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
          Q <= ~Q;
          Qnot <= Q;
        end
      endcase
    end
  end
endmodule
