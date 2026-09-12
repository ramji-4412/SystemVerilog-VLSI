// Comparator 4Bit - System Verilog

module comparator_4bit(
  input logic [3:0]A,
  input logic [3:0]B,
  output logic Y1,
  output logic Y2,
  output logic Y3
);
  
  always_comb begin
    
    Y1 = ( A > B );
    Y2 = ( A < B );
    Y3 = ( A == B );
    
  end
endmodule
