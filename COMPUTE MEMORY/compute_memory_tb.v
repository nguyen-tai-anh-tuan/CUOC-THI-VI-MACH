`timescale 1ns / 1ps

module compute_memory_tb;

    // Định nghĩa tín hiệu
    reg clk;
    reg reset;
    reg [5:0] addr;
    wire [31:0] k_out;

    // Khởi tạo module DUT (Design Under Test)
    compute_memory uut (
        .clk(clk),
        .reset(reset),
        .addr(addr),
        .k_out(k_out)
    );

    // Tạo tín hiệu clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ clock 10ns
    end

    // Thử nghiệm
    initial begin
        // Khởi tạo
        reset = 1;
        addr = 0;
        #20;
        reset = 0;

        // Kiểm tra các địa chỉ từ 0 đến 63
        $display("Testing Compute Memory K[t] values:");
        for (addr = 0; addr < 64; addr = addr + 1) begin
            #10;
            $display("Addr: %d, K_out: %h", addr, k_out);
        end

        // Kết thúc mô phỏng
        #50 $finish;
    end

endmodule