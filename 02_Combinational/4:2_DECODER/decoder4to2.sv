// 4:2 Decoder - System Verilog

module decoder4to2(
  input logic [3:0]D,
  output logic [1:0]Y
);
  
  always_comb begin
    
    Y[1] = D[3] | D[2];
    Y[0] = D[3] | D[1];
    
  end
endmodule
