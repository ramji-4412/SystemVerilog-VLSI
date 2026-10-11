// Testbench for Hamming Code - System Verilog

module tb;

    parameter int DATA_WIDTH = 4;

    localparam int PARITY_WIDTH =
        hamming_pkg::calc_parity_bits(DATA_WIDTH);

    localparam int CODE_WIDTH = DATA_WIDTH + PARITY_WIDTH;

    logic [DATA_WIDTH-1:0] data;
    logic [CODE_WIDTH-1:0] codeword;

    logic [CODE_WIDTH-1:0] expected_codeword;

    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate the DUT
    hamming_encoder #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .data(data),
        .codeword(codeword)
    );

    // Reference model: independently calculate expected codeword
    function automatic logic [CODE_WIDTH-1:0]
        reference_encoder(input logic [DATA_WIDTH-1:0] d);

        logic [CODE_WIDTH-1:0] temp_code;
        integer i;
        integer j;
        integer p;
        integer data_idx;
        logic parity;

        begin
            temp_code = '0;
            data_idx = 0;

            // Place data bits in non-parity positions
            for (i = 1; i <= CODE_WIDTH; i = i + 1) begin
                if ((i & (i - 1)) != 0) begin
                    temp_code[i-1] = d[data_idx];
                    data_idx = data_idx + 1;
                end
            end

            // Calculate parity bits
            for (p = 1; p <= CODE_WIDTH; p = p * 2) begin
                parity = 1'b0;

                for (j = 1; j <= CODE_WIDTH; j = j + 1) begin
                    if (((j & p) != 0) && (j != p)) begin
                        parity = parity ^ temp_code[j-1];
                    end
                end

                temp_code[p-1] = parity;
            end

            reference_encoder = temp_code;
        end
    endfunction

    // Apply input, wait, and check the output
    task automatic check_input(input logic [DATA_WIDTH-1:0] test_data);
        begin
            data = test_data;
            expected_codeword = reference_encoder(test_data);

            #1;

            if (codeword === expected_codeword) begin
                $display(
                    "PASS | data=%b | codeword=%b",
                    data, codeword
                );
                pass_count = pass_count + 1;
            end
            else begin
                $error(
                    "FAIL | data=%b | Expected=%b | Actual=%b",
                    data, expected_codeword, codeword
                );
                fail_count = fail_count + 1;
            end
        end
    endtask

    // Test all possible input combinations
    initial begin
      
      	$dumpfile("dump.vcd");
      	$dumpvars(1,tb);

        $display("Starting Hamming Encoder Verification");
        $display("-------------------------------------");

        for (int k = 0; k < (2**DATA_WIDTH); k = k + 1) begin
            check_input(k);
        end

        $display("-------------------------------------");
        $display("Total tests : %0d", pass_count + fail_count);
        $display("Passed      : %0d", pass_count);
        $display("Failed      : %0d", fail_count);

        if (fail_count == 0)
            $display("RESULT: ALL TESTS PASSED");
        else
            $display("RESULT: VERIFICATION FAILED");

        $finish;
    end

endmodule
