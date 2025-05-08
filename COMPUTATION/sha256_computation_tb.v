`timescale 1ns / 1ps

module sha256_computation_tb;

    // Đầu vào
    reg clk;
    reg reset;
    reg [31:0] w_in;
    reg [31:0] k_in;
    reg [255:0] h_in;

    // Đầu ra
    wire [255:0] h_out;
    wire done;

    // Khởi tạo module
    sha256_computation uut (
        .clk(clk),
        .reset(reset),
        .w_in(w_in),
        .k_in(k_in),
        .h_in(h_in),
        .h_out(h_out),
        .done(done)
    );

    // Tạo xung clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ clock 10ns
    end

    // Các giá trị K (hằng số SHA-256, chỉ lấy 4 giá trị đầu để minh họa)
    reg [31:0] K [0:63];
    initial begin
        K[0] = 32'h428a2f98;
        K[1] = 32'h71374491;
        K[2] = 32'hb5c0fbcf;
        K[3] = 32'he9b5dba5;
        // Các giá trị K khác có thể được thêm vào nếu cần
    end

    // Mô phỏng
    integer i;
    initial begin
        // Khởi tạo tín hiệu
        reset = 1;
        w_in = 0;
        k_in = 0;
        h_in = 256'h6a09e667_bb67ae85_3c6ef372_a54ff53a_510e527f_9b05688c_1f83d9ab_5be0cd19; // Giá trị H ban đầu của SHA-256
        #20;
        reset = 0;

        // Mô phỏng 64 vòng lặp
        for (i = 0; i < 64; i = i + 1) begin
            w_in = 32'h00000000 + i; // Giá trị W giả lập (tăng dần để kiểm tra)
            k_in = K[i % 4];         // Sử dụng K lặp lại để minh họa
            #10;                     // Đợi 1 chu kỳ clock
        end

        // Chờ cho đến khi hoàn thành
        wait(done);
        #20;
        $display("Kết quả mã băm: %h", h_out);
        $finish;
    end

    // Theo dõi tín hiệu
    initial begin
        $monitor("Time=%0t | round=%d | a=%h | e=%h | h_out=%h | done=%b", 
                 $time, uut.round, uut.a, uut.e, h_out, done);
    end

endmodule