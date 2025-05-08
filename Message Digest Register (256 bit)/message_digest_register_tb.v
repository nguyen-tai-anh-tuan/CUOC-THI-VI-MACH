`timescale 1ns / 1ps

module message_digest_register_tb;

    // Định nghĩa tín hiệu kiểm tra
    reg clk;
    reg reset;
    reg update;
    reg [255:0] new_digest;
    wire [255:0] digest;

    // Khởi tạo module DUT (Design Under Test)
    message_digest_register dut (
        .clk(clk),
        .reset(reset),
        .update(update),
        .new_digest(new_digest),
        .digest(digest)
    );

    // Tạo tín hiệu đồng hồ
    initial begin
        clk = 0;
        forever #8 clk = ~clk; // Chu kỳ đồng hồ 16ns (tương ứng 62.5 MHz)
    end

    // Quá trình kiểm tra
    initial begin
        // Khởi tạo
        reset = 1;
        update = 0;
        new_digest = 256'h0;
        #24;
        
        // Hủy reset
        reset = 0;
        #16;
        
        // Cập nhật với giá trị băm mới (testcase 1: mã hóa một khối)
        update = 1;
        new_digest = 256'hba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad; // SHA-256("abc")
        #16;
        update = 0;
        #32;
        
        // Cập nhật với giá trị băm khác (testcase 2: dữ liệu dài)
        update = 1;
        new_digest = 256'he9b5b33f5c64c623175ac6e0e0e8e3a4f7e84b8f5d5b9c5e0e8e3a4f7e84b8f; // Giá trị mẫu
        #16;
        update = 0;
        #32;
        
        // Kết thúc mô phỏng
        $finish;
    end

    // Theo dõi kết quả
    initial begin
        $monitor("Time=%0t reset=%b update=%b new_digest=%h digest=%h", $time, reset, update, new_digest, digest);
    end

endmodule