// Carry Look Ahead Adder Testbench - System Verilog

module CLA_4_bit_tb;
  logic [3:0] A;
  logic [3:0] B;
  logic C;
  logic [3:0] Sum;
  logic Carry;
  
  CLA_4_bit dut(
    .A(A),
    .B(B),
    .C(C),
    .Sum(Sum),
    .Carry(Carry)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,CLA_4_bit_tb);
    
    $monitor("A=%b | B=%b | C=%b | Sum=%b | Carry=%b",A,B,C,Sum,Carry);
    
    for(int i=0;i<512;i++) begin
      {A,B,C} = i;
      #10;
      
    end
    $finish;
    end
endmodule
