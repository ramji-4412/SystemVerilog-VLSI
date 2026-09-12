// 3:8 Decoder - System Verilog

module decoder3to8(
  input logic [2:0]I,
  output logic [7:0]Y
);
  
  always_comb begin
    
    for(int i=0;i<8;i++) begin
      if(I == i)begin
        Y = 8'b0;
        Y[i] = 1'b1;
      end
    end
    
  end
endmodule
