// 1:2 DEMUX - SYSTEM VERILOG

module demux1to2(
  input logic Y,
  input logic S,
  output logic I0,
  output logic I1
);
  always_comb begin
    
    case(S)
      
      1'b0: begin
        I0 = Y;
        I1 = 1'b0;
      end
      
      1'b1: begin
        I0 = 1'b0;
        I1 = Y;
      end
      
      default: begin
        I0 = 1'b0;
        I1 = 1'b0;
      end
    endcase
    end
 endmodule
