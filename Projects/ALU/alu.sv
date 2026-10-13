// Parameterized N-bit ALU

// Parameterized ALU

module ALU #(
  parameter N = 8
)(
  input logic [N-1:0]A,
  input logic [N-1:0]B,
  input logic [3:0]sel,
  input logic cin,
  
  output logic [N-1:0]Y,
  output logic carry,
  output logic zero,
  output logic negative,
  output logic overflow
);
  
  logic [N:0]sum_ext;
  
  always_comb begin
    
    Y = '0;
    sum_ext = '0;
    carry = 1'b0;
    zero = 1'b0;
    overflow = 1'b0;
    negative = 1'b0;
    
    case(sel)
      
      // ADDITION
      4'b0000: begin
        sum_ext = {1'b0,A} + {1'b0,B} + cin;
        Y = sum_ext[N-1:0];
        carry = sum_ext[N];
      end
      
      // SUBTRACTION
      4'b0001: begin
        sum_ext = {1'b0,A} - {1'b0,B} - cin;
        Y = sum_ext[N-1:0];
        carry = ({1'b0,A} >= ({1'b0,B}+cin));
      end
      
      // BITWISE AND
      4'b0010: begin
        Y = A&B;
      end
      
      // BITWISE OR
      4'b0011: begin
        Y = A|B;
      end
      
      // BITWISE XOR
      4'b0100: begin
        Y = A^B;
      end
      
      // BITWISE COMPLEMENT
      4'b0101: begin
        Y = ~A;
      end
      
      // LOGICAL LEFT SHIFT
      4'b0110: begin
        Y = A<<1;
      end
      
      // LOGICAL RIGHT SHIFT
      4'b0111: begin
        Y = A>>1;
      end
      
      // ARITHMETIC LEFT SHIFT
      4'b1000: begin
        Y = $signed(A)<<<1;
      end
      
      // ARITHMETIC RIGHT SHIFT
      4'b1001: begin
        Y = $signed(A)>>>1;
      end
      
      // ROTATE LEFT
      4'b1010: begin
        Y = {A[N-2:0],A[N-1]};
      end
      
      // ROTATE RIGHT
      4'b1011: begin
        Y = {A[0],A[N-1:1]};
      end
      
      // COMPARE
      4'b1100: begin
        if(A>B) 
          Y[0] = 1;
        else if(A==B) 
          Y[1] = 1;
        else 
          Y[2] = 1;
      end
       
      // INCREMENT
      4'b1101: begin
        Y = A + 1'b1;
      end
      
      // DECREMENT
      4'b1110: begin
        Y = A - 1'b1;
      end
      
      // ARITHMETIC COMPLEMENT
      4'b1111: begin
        Y = -A;
      end
    endcase
    zero     = (Y == '0);
	negative = Y[N-1];
  end
endmodule
