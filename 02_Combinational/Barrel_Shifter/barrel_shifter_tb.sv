// 8-bit Barrel Shifter Testbench -  System Verilog

module barrel_shifter_tb;
  logic [7:0]a;
  logic [2:0]sel;
  logic [7:0]shift_right;
  logic [7:0]shift_left;
  
  barrel_shifter dut(
    .a(a),
    .sel(sel),
    .shift_left(shift_left),
    .shift_right(shift_right)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,barrel_shifter_tb);
    
    $monitor("A = %b | Shift by = %d | Left_Shifted Output = %b | Right_Shifted Output = %b",a,sel,shift_left,shift_right);
    
    a = 11100010;
    
    for(int i=0;i<8;i++)begin
      sel = i;
      #10;
    end
    
    $finish;
  end
endmodule
