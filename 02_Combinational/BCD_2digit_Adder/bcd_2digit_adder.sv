// 2 Digit BCD Adder - System Verilog

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



module BCD_2digit_adder(
  input logic [7:0]a,
  input logic [7:0]b,
  input logic cin,
  output logic [7:0]sum,
  output logic carry
);
  
  logic [3:0]units_sum;
  logic [3:0]tens_sum;
  
  logic units_carry;
  logic tens_carry;
  
  BCD_adder units_adder(
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(cin),
    .sum(units_sum),
    .carry(units_carry)
  );
  
  BCD_adder tens_adder(
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(units_carry),
    .sum(tens_sum),
    .carry(tens_carry)
  );
  
  assign sum = {tens_sum , units_sum};
  assign carry = tens_carry;
  
endmodule
