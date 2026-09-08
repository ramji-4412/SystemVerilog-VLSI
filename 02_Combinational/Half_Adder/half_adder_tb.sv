// Half Adder Testbench - System Verilog

module half_adder_tb;
  logic a;
  logic b;
  logic sum;
  logic carry;
  
  half_adder dut(
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,half_adder_tb);
    
    $monitor("a=%b | b=%b | sum=%b | carry =%b", a,b,sum,carry);
    
    a=0;
    b=0;
    #10;
    
    a=0;
    b=1;
    #10;
    
    a=1;
    b=0;
    #10;
    
    a=1;
    b=1;
    #10;
    
    $finish;
  end
endmodule
