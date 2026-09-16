// BCD Adder Tesbench - System Verilog

module BCD_adder_tb;
  logic [3:0]a;
  logic [3:0]b;
  logic cin;
  logic [3:0]sum;
  logic carry;
  
  BCD_adder dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .carry(carry)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,BCD_adder_tb);
    
    $monitor("a=%b | b=%b | cin=%b | sum=%b | carry=%b",a,b,cin,sum,carry);
    
    cin = 0;
    
    for(int i=0;i<10;i++)begin
      a=i;
      b=i;
      #10;
    end
    
    $finish;
  end
endmodule
