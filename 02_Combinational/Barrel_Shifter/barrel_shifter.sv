// 8-bit Barrel Shifter - System Verilog

module barrel_shifter (
    input  logic [7:0] a,
    input  logic [2:0] sel,
    output logic [7:0] shift_left,
    output logic [7:0] shift_right
);

    logic [7:0] left_stage1, left_stage2;
    logic [7:0] right_stage1, right_stage2;

    always_comb begin

        // Stage 1: shift by 1
        if (sel[0]) begin
            left_stage1  = a << 1;
            right_stage1 = a >> 1;
        end
        else begin
            left_stage1  = a;
            right_stage1 = a;
        end


        // Stage 2: shift by 2
        if (sel[1]) begin
            left_stage2  = left_stage1 << 2;
            right_stage2 = right_stage1 >> 2;
        end
        else begin
            left_stage2  = left_stage1;
            right_stage2 = right_stage1;
        end


        // Stage 3: shift by 4
        if (sel[2]) begin
            shift_left  = left_stage2 << 4;
            shift_right = right_stage2 >> 4;
        end
        else begin
            shift_left  = left_stage2;
            shift_right = right_stage2;
        end

    end

endmodule


// Basic Implementation

// module barrel_shifter(
//   input logic [7:0]a,
//   input logic [2:0]sel,
//   output logic [7:0]shift_left,
//   output logic [7:0]shift_right
// );
  
//   always_comb begin
    
//     case(sel)
//       3'b000: begin
//         shift_left = a<<0;
//         shift_right = a>>0;
//       end
//       3'b001: begin
//         shift_left = a<<1;
//         shift_right = a>>1;
//       end
//       3'b010: begin
//         shift_left = a<<2;
//         shift_right = a>>2;
//       end
//       3'b011: begin
//         shift_left = a<<3;
//         shift_right = a>>3;
//       end
//       3'b100: begin
//         shift_left = a<<4;
//         shift_right = a>>4;
//       end
//       3'b101: begin
//         shift_left = a<<5;
//         shift_right = a>>5;
//       end
//       3'b110: begin
//         shift_left = a<<6;
//         shift_right = a>>6;
//       end
//       3'b111: begin
//         shift_left = a<<7;
//         shift_right = a>>7;
//       end
//     endcase
//   end
// endmodule
