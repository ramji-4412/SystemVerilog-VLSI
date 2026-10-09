// Parametrized Leading Zero Detector - System Verilog

module LZD #(
  parameter N = 8
)(
  input logic [N-1:0]a,
  output logic [$clog2(N+1)-1:0]count
);
  
  always_comb begin
    count =N;
    for(int i=N-1;i>=0;i--)begin
      if(a[i]==1'b1 && count==N)
        count = N-1-i;
    end
  end
endmodule
