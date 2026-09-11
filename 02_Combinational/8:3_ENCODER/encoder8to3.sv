// 8:3 Encoder - System Verilog

module encoder8to3(
  input logic [7:0]I,
  output logic [2:0]Y
);
  
  always_comb begin
    
    for(int i=0;i<8;i++) begin
      if(I[i]==1'b1)begin
        Y = i;
      end
    end
    
  end
endmodule
