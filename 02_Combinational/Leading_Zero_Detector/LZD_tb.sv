// Testbench for Leading Zero Detector - System Verilog

module LZD_tb;
  parameter N = 8;
  logic [N-1:0]a;
  logic [$clog2(N+1)-1:0]count;
  
  LZD #(.N(N)) dut(
    .a(a),
    .count(count)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,LZD_tb);
    
    $monitor("Time = %0t | a = %b | count = %d", $time, a, count);
    
    a = 8'b10101010;
    #10;
    
    a = 8'b01010101;
    #10;
    
    a = 8'b00100100;
    #10;
    
    a = 8'b00011000;
    #10;
    
    a = 8'b00001111;
    #10;
    
    a = 8'b00000111;
    #10;
    
    a = 8'b00000010;
    #10;
    
    a = 8'b00000001;
    #10;
    
    $finish;
  end
endmodule
