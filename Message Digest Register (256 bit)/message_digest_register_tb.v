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
        forever #5 clk = ~clk; // Chu kỳ đồng hồ 10ns
    end

    // Quá trình kiểm tra
    initial begin
        // Khởi tạo
        reset = 1;
        update = 0;
        new_digest = 256'h0;
        #20;
        
        // Hủy reset
        reset = 0;
        #10;
        
        // Cập nhật giá trị băm mới
        update = 1;
        new_digest = 256'h6a09e667bb67ae853c6ef372a54ff53a510e527f9b05688c1f83d9ab5be0cd1a;
        #10;
        update = 0;
        #20;
        
        // Cập nhật giá trị băm khác
        update = 1;
        new_digest = 256'h7a0b9e68cc6baf854de7f373b54gf53b510e527f9b05688c1f83d9ab5be0cd2b;
        #10;
        update = 0;
        #20;
        
        // Kết thúc mô phỏng
        $finish;
    end

    // Theo dõi kết quả
    initial begin
        $monitor("Time=%0t reset=%b update=%b new_digest=%h digest=%h", $time, reset, update, new_digest, digest);
    end

endmodule