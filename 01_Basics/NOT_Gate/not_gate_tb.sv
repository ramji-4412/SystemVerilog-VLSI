// NOT Gate Testbench - System Verilog

module tb_not_sv;
  logic a;
  logic y;
  
  not_sv dut(
    .a(a),
    .y(y)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,tb_not_sv);
    
    $monitor("a=%b | y=%b", a,y);
    
    a=0;
    #10;
    
    a=1;
    #10;
    
    $finish;
  end
endmodule
