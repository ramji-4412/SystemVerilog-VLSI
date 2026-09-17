// 2 Digit BCD Adder Testbench - System Verilog

module BCD_2digit_adder_tb;
  
  logic [7:0]a;
  logic [7:0]b;
  logic cin;
  logic [7:0]sum;
  logic carry;
  
  BCD_2digit_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .carry(carry)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,BCD_2digit_adder_tb);
    
    $monitor("a=%b | b=%b | cin=%b | sum=%b | carry=%b",a,b,cin,sum,carry);
    
        a = 8'b0001_0010;
        b = 8'b0010_0011;
        cin = 0;
        #10;

        a = 8'b0010_0111;
        b = 8'b0011_0101;
        cin = 0;
        #10;

        a = 8'b0100_0101;
        b = 8'b0011_0010;
        cin = 0;
        #10;
    
        a = 8'b0101_1000;
        b = 8'b0110_0111;
        cin = 0;
        #10;

        a = 8'b1001_1001;
        b = 8'b1001_1001;
        cin = 0;
        #10;

        a = 8'b0010_0101;
        b = 8'b0001_0100;
        cin = 1;
        #10;
    
    $finish;
  end
endmodule
