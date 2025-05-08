`timescale 1ns / 1ps

module k_constant_block_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg [5:0] round;
    wire [31:0] k_out;

    // Instantiate the Unit Under Test (UUT)
    k_constant_block uut (
        .clk(clk),
        .reset(reset),
        .round(round),
        .k_out(k_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        reset = 1;
        round = 0;
        #20;
        
        reset = 0;
        #10;

        // Test all 64 rounds
        $display("Testing K constants for all 64 rounds:");
        for (round = 0; round < 64; round = round + 1) begin
            #10;
            $display("Round %0d: K_out = %h", round, k_out);
        end

        // Test reset
        #10;
        reset = 1;
        #10;
        $display("After reset: K_out = %h", k_out);

        #10;
        $finish;
    end

endmodule