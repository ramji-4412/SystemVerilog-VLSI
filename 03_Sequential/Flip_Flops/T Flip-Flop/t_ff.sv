module t_ff(
  input logic T,
  input logic clk,
  input logic rst_n,
  output logic Q,
  output logic Qnot
);
  
  always_ff @(posedge clk or negedge rst_n) begin
    
    if(!rst_n)
      Q <= 1'b0;
    else if(T == 1'b1)
      Q <= ~Q;
    else
      Q <= Q;
  end
  
  assign Qnot = ~Q;
endmodule    
