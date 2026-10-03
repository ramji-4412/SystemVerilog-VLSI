// 4-bit CSA Testbench - System Verilog

module csa_4bit_tb;
  logic [3:0]a;
  logic [3:0]b;
  logic cin;
  logic [3:0]sum;
  logic cout;
  
  csa_4bit dut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,csa_4bit_tb);
    
    $monitor("A = %b | B = %b | Cin = %b | Cout = %b | Sum = %b", a,b,cin,cout,sum);
    
    for(int i=0;i<512;i++)begin
      {a,b,cin} = i;
      #10;
    end
  $finish;
  end
endmodule
