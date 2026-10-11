// Hamming Code - System Verilog

package hamming_pkg;

    // Calculate the number of parity bits required
    function automatic integer calc_parity_bits(input integer m);
        integer r;
        begin
            r = 0;

            while ((2**r) < (m + r + 1)) begin
                r = r + 1;
            end

            calc_parity_bits = r;
        end
    endfunction

endpackage


module hamming_encoder #(
    parameter int DATA_WIDTH = 4,

    parameter int PARITY_WIDTH =
        hamming_pkg::calc_parity_bits(DATA_WIDTH),

    parameter int CODE_WIDTH = DATA_WIDTH + PARITY_WIDTH
)(
    input  logic [DATA_WIDTH-1:0] data,
    output logic [CODE_WIDTH-1:0] codeword
);

    integer data_index;
    integer p;
    integer pos;
    logic parity_value;

    always_comb begin

        // Initialize the complete codeword
        codeword = '0;
        data_index = 0;

        // Step 1: Place data bits in non-parity positions
        for (pos = 1; pos <= CODE_WIDTH; pos = pos + 1) begin

            // A power-of-two position is reserved for parity
            if ((pos & (pos - 1)) != 0) begin
                codeword[pos-1] = data[data_index];
                data_index = data_index + 1;
            end

        end

        // Step 2: Calculate and insert parity bits
        for (p = 1; p <= CODE_WIDTH; p = p * 2) begin

            parity_value = 1'b0;

            for (pos = 1; pos <= CODE_WIDTH; pos = pos + 1) begin

                if (((pos & p) != 0) && (pos != p)) begin
                    parity_value = parity_value ^ codeword[pos-1];
                end

            end

            codeword[p-1] = parity_value;

        end

    end

endmodule
