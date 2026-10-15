// SR Latch - System Verilog

module SR_latch(
  input logic S,
  input logic R,
  output logic Q,
  output logic Qbar
);
  
  always_latch begin
    
    // Can be used when we don't use always_latch procedural block
    //     assign Q    = ~(R | Qbar);   
   	//     assign Qbar = ~(S | Q);
    
    case({S,R})
      
      2'b00: begin
      end
      
      2'b01: begin
        Q <= 1'b0;
        Qbar <= 1'b1;
      end
      
      2'b10: begin
        Q <= 1'b1;
        Qbar <= 1'b0;
      end
      
      2'b11: begin
        Q <= 1'bx;
        Qbar <= 1'bx;
      end
      
    endcase
  end
endmodule
