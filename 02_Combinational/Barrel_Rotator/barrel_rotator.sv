// 8-Bit Barrel Rotator

module barrel_rotator (
    input  logic [7:0] a,
    input  logic [2:0] sel,
    output logic [7:0] rotate_left,
    output logic [7:0] rotate_right
);

    logic [7:0] left_stage1, left_stage2;
    logic [7:0] right_stage1, right_stage2;

    always_comb begin

        // Stage 1: rotate by 1
        if (sel[0]) begin
            left_stage1  = {a[6:0], a[7]};
            right_stage1 = {a[0], a[7:1]};
        end
        else begin
            left_stage1  = a;
            right_stage1 = a;
        end


        // Stage 2: rotate by 2
        if (sel[1]) begin
            left_stage2  = {left_stage1[5:0], left_stage1[7:6]};
            right_stage2 = {right_stage1[1:0], right_stage1[7:2]};
        end
        else begin
            left_stage2  = left_stage1;
            right_stage2 = right_stage1;
        end


        // Stage 3: rotate by 4
        if (sel[2]) begin
            rotate_left  = {left_stage2[3:0], left_stage2[7:4]};
            rotate_right = {right_stage2[3:0], right_stage2[7:4]};
        end
        else begin
            rotate_left  = left_stage2;
            rotate_right = right_stage2;
        end

    end

endmodule
