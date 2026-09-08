// Full Subtractor Testbench - System Verilog

module full_subtractor_tb;
  logic a,b,c;
  logic difference, borrow;
  
  full_subtractor dut(
    .a(a),
    .b(b),
    .c(c),
    .difference,
    .borrow(borrow)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,full_subtractor_tb);
    
    $monitor("a=%b | b=%b | c=%b | difference=%b | borrow=%b",a,b,c,difference,borrow);
    
    for(int i=0;i<8;i++) begin
      {a,b,c} = i;
      #10;
    end
    
    $finish;
  end
endmodule
