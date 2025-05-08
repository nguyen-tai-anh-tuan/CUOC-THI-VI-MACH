`timescale 1ns / 1ps

module message_scheduler (
    input clk,
    input reset,
    input [511:0] msg_block,
    output reg [31:0] w [0:63]
);

    integer i;
    reg [31:0] w_temp [0:63];

    // Initialize the first 16 words directly from the message block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 64; i = i + 1) begin
                w[i] <= 0;
            end
        end else begin
            // Load first 16 words (0-15)
            for (i = 0; i < 16; i = i + 1) begin
                w[i] <= msg_block[(511 - 32*i) -: 32];
            end
            // Compute remaining words (16-63)
            for (i = 16; i < 64; i = i + 1) begin
                w_temp[i] <= w[i-2] + {w[i-7][6:0], w[i-7][31:7]} + 
                            {w[i-15][17:0], w[i-15][31:18]} + w[i-16];
                w[i] <= w_temp[i];
            end
        end
    end

endmodule