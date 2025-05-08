`timescale 1ns / 1ps

module message_scheduler_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg [511:0] msg_block;
    wire [31:0] w [0:63];

    // Instantiate the module
    message_scheduler uut (
        .clk(clk),
        .reset(reset),
        .msg_block(msg_block),
        .w(w)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize signals
        reset = 1;
        msg_block = 512'h0000000000000000000000000000000000000000000000000000000000000000;
        #20;
        reset = 0;

        // Test case 1: Message block with "abc" padded (per SHA-256 standard)
        msg_block = 512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
        #200;

        // Test case 2: Random message block
        msg_block = 512'hfedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210;
        #200;

        // End simulation
        #100 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t reset=%b msg_block=%h w[0]=%h w[63]=%h", $time, reset, msg_block, w[0], w[63]);
    end

endmodule