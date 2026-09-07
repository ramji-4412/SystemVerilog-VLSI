// XOR Gate Testbench - System Verilog

module xor_gate_tb;
  logic a;
  logic b;
  logic y;
  
  xor_gate dut(
    .a(a),
    .b(b),
    .y(y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,xor_gate_tb);
    
    $monitor("a = %b | b = %b | y = %b",a,b,y);
    
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
