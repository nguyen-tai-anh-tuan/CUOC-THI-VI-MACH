`timescale 1ns / 1ps

module message_scheduler (
    input clk,
    input reset,
    input [511:0] msg_block,
    output reg [31:0] w [0:63]
);

    integer i;
    reg [31:0] s0, s1;

    // Initialize the first 16 words directly from the message block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 64; i = i + 1) begin
                w[i] <= 0;
            end
        end else begin
            // Load first 16 words (0-15)
            for (i = 0; i < 16; i = i + 1) begin
                w[i] <= msg_block[(511 - (i * 32)) -: 32];
            end
            // Compute remaining words (16-63)
            for (i = 16; i < 64; i = i + 1) begin
                s0 = (w[i-15] >> 7) ^ (w[i-15] >> 18) ^ (w[i-15] >> 3);  // σ0
                s1 = (w[i-2] >> 17) ^ (w[i-2] >> 19) ^ (w[i-2] >> 10);  // σ1
                w[i] <= w[i-16] + s0 + w[i-7] + s1;
            end
        end
    end

endmodule