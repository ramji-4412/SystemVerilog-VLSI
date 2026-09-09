// 2:1 MUX - System Verilog

module mux2to1(
  input logic I0,
  input logic I1,
  input logic S,
  output logic Y
);
  
  always_comb begin
    
    if(S) begin
      Y = I1;
    end
    else begin
      Y = I0;
    end
    
  end
endmodule
