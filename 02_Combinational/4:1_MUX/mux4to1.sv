// 4:1 MUX - System Verilog

module mux4to1(
  input logic I0,
  input logic I1,
  input logic I2,
  input logic I3,
  input logic [1:0] S,
  output logic Y
);
  
  always_comb begin
    
    case(S)
      2'b00: Y=I0;
      2'b01: Y=I1;
      2'b10: Y=I2;
      2'b11: Y=I3;
    endcase
    
    end
endmodule   
