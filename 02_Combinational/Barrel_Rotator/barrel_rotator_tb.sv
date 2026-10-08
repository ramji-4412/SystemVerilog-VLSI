// 8 bit Barrel Rotator Testbench - System Verilog

module barrel_rotator_tb;
  logic [7:0]a;
  logic [2:0]sel;
  logic [7:0]rotate_left;
  logic [7:0]rotate_right;
  
  barrel_rotator dut(
    .a(a),
    .sel(sel),
    .rotate_left(rotate_left),
    .rotate_right(rotate_right)
  );
  
  initial begin
    
    $dumpfile("dump.vcd");
    $dumpvars(1,barrel_rotator_tb);
    
    $monitor("A = %b | No. of rotations = %d | Left_Rotated Output = %b | Right_Rotated Output = %b",a,sel,rotate_left,rotate_right);
    
    a = 8'b01100110;
    
    for(int i=0;i<8;i++)begin
      sel = i;
      #10;
    end
    
    $finish;
  end
endmodule
