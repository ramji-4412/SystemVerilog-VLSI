// 2:4 Decoder - System Verilog

module decoder2to4(
  input logic [1:0]I,
  output logic Y0,
  output logic Y1,
  output logic Y2,
  output logic Y3
);
  
  always_comb begin
    
    case(I) 
      2'b00: begin
        Y0 = 1'b1;
        Y1 = 1'b0;
        Y2 = 1'b0;
        Y3 = 1'b0;
      end
      2'b01: begin
        Y0 = 1'b0;
        Y1 = 1'b1;
        Y2 = 1'b0;
        Y3 = 1'b0;
      end
      2'b10: begin
        Y0 = 1'b0;
        Y1 = 1'b0;
        Y2 = 1'b1;
        Y3 = 1'b0;
      end
      2'b11: begin
        Y0 = 1'b0;
        Y1 = 1'b0;
        Y2 = 1'b0;
        Y3 = 1'b1;
      end
      default: begin
        Y0 = 1'b0;
        Y1 = 1'b0;
        Y2 = 1'b0;
        Y3 = 1'b0;
      end
    endcase
  end
endmodule  
