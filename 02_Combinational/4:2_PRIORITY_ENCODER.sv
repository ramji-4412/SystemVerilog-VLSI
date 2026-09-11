// 4:2 Priority Enocder - System Verilog

module priorityencoder4to2(
  input logic [3:0]I,
  output logic [1:0]Y
);
  
  always_comb begin
     
    for(int i=0;i<4;i++) begin
      if(I[i]==1'b1)begin
        Y=i;
      end
    end
  end
endmodule
