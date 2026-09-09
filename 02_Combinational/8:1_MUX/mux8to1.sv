// 8:1 MUX - System Verilog

module mux8to1(
  input logic I0,
  input logic I1,
  input logic I2,
  input logic I3,
  input logic I4,
  input logic I5,
  input logic I6,
  input logic I7,
  input logic [2:0]S,
  output logic Y
);
  
  always_comb begin
    
    case(S)
      3'b000: Y=I0;
      3'b001: Y=I1;
      3'b010: Y=I2;
      3'b011: Y=I3;
      3'b100: Y=I4;
      3'b101: Y=I5;
      3'b110: Y=I6;
      3'b111: Y=I7;
    endcase
    
  end
endmodule
