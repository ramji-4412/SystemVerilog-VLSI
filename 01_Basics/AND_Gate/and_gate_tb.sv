// Testbench AND Gate - System Verilog

module tb_and_sv;
  logic a;
  logic b;
  logic y;
  
  and_sv dut(
    .a(a),
    .b(b),
    .y(y)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,tb_and_sv);
    
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
