// Comparator 1Bit Testbench - System Verilog

module comparator_1bit_tb;
  logic A,B;
  logic Y1,Y2,Y3;
  
  comparator_1bit dut(
    .A(A),
    .B(B),
    .Y1(Y1),
    .Y2(Y2),
    .Y3(Y3)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,comparator_1bit_tb);
    
    $display("Y1 => A greater than B");
    $display("Y2 => B greater than A");
    $display("Y3 => A equals B");
    
    $monitor("A=%b | B=%b | Y1=%b | Y2=%b | Y3=%b",A,B,Y1,Y2,Y3);
    
    for(int i=0;i<4;i++)begin
      {A,B} = i;
      #10;
    end
    
    $finish;
  end
endmodule
