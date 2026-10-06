// 4-Bit Binary Multiplier Testbench - System Verilog

module binary_multiplier_tb;
  
  logic [3:0]a;
  logic [3:0]b;
  logic [7:0]p;
  
  binary_multiplier dut(
    .a(a),
    .b(b),
    .p(p)
  );
  
  initial begin
    
    $dumpfile("dumpfile.vcd");
    $dumpvars(1,binary_multiplier_tb);
    
    $monitor("a = %d| b = %d | p = %d",a,b,p);
    
    a = 4'd15;
    b = 4'd15;
    #10;
    
    a = 4'd12;
    b = 4'd10;
    #10;
    
    a = 4'd10;
    b = 4'd0;
    #10;
    
  end
endmodule
