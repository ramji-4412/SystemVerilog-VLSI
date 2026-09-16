// BCD Adder - System Verilog

module BCD_adder(
  input logic [3:0]a,
  input logic [3:0]b,
  input logic cin,
  output logic [3:0]sum,
  output logic carry
);
  
  logic [4:0] binary_sum;
  logic correction;
  logic [4:0] corrected_sum;
  
  always_comb begin
    
    binary_sum = a+b+cin;
    
    correction = binary_sum[4] || 
    			 (binary_sum[3] && binary_sum[2]) ||
     			 (binary_sum[3] && binary_sum[1]);
    
    if(correction)
      corrected_sum = binary_sum + 5'b00110;
    
    else
      corrected_sum = binary_sum;
    
    sum = corrected_sum[3:0];
    carry = corrected_sum[4];
    
  end
endmodule
