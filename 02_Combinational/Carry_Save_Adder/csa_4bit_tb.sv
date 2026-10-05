// Testbench for 4-bit Carry Save Adder - System Verilog

module csa_4bit_tb;
  logic [3:0]A;
  logic [3:0]B;
  logic [3:0]C;
  logic [4:0]Sum;
  
  csa_4bit dut(
    .A(A),
    .B(B),
    .C(C),
    .Sum(Sum)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,csa_4bit_tb);
    
    $monitor("A=%d | B=%d | C=%d | Sum = %d",A,B,C,Sum);
    
    A = 4'd10;
    B = 4'd2;
    C = 4'd8;
    #10;
    
    A = 4'd0;
    B = 4'd2;
    C = 4'd8;
    #10;
    
  	$finish;
  end
endmodule
