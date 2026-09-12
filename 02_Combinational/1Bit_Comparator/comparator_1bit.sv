// Comparator 1Bit - System Verilog

module comparator_1bit(
  input logic A,
  input logic B,
  output logic Y1,
  output logic Y2,
  output logic Y3
);
  
  always_comb begin
    
    Y1 = (A>B);
    Y2 = (A<B);
    Y3 = (A==B);
    
  end
endmodule
