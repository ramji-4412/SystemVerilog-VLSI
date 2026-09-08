// Full Adder Testbench - System Verilog

module full_adder_tb;
  logic a;
  logic b;
  logic c;
  logic sum;
  logic carry;
  
  full_adder dut(
    .a(a),
    .b(b),
    .c(c),
    .sum(sum),
    .carry(carry)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,full_adder_tb);
    $monitor("a=%b | b=%b | c=%b | sum=%b | carry = %b",a,b,c,sum,carry);
    
    for(int i=0;i<8;i++) begin
    	{a,b,c} = i;
    	#10;
    end
    
    $finish;
  end
endmodule
