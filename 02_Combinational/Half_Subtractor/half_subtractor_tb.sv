// Half Subtractor Testbench - System Verilog

module half_subtractor_tb;
  logic a;
  logic b;
  logic difference;
  logic borrow;
  
  half_subtractor dut(
    .a(a),
    .b(b),
    .difference(difference),
    .borrow(borrow)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,half_subtractor_tb);
    
    $monitor("a=%b | b=%b | difference=%b | borrow=%b",a,b,difference,borrow);
    
    for(int i=0;i<4;i++) begin
      {a,b} = i;
      #10;
    end
    
    $finish;
  end
endmodule
