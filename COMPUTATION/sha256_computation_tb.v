`timescale 1ns / 1ps

module sha256_computation_tb;

    // Đầu vào
    reg clk;
    reg reset;
    reg start;
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
        .start(start),
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

    // Các hằng số K của SHA-256 (lấy từ chuẩn NIST)
    reg [31:0] K [0:63];
    initial begin
        K[0]  = 32'h428a2f98; K[1]  = 32'h71374491; K[2]  = 32'hb5c0fbcf; K[3]  = 32'he9b5dba5;
        K[4]  = 32'h3956c25b; K[5]  = 32'h59f111f1; K[6]  = 32'h923f82a4; K[7]  = 32'hab1c5ed5;
        K[8]  = 32'hd807aa98; K[9]  = 32'h12835b01; K[10] = 32'h243185be; K[11] = 32'h550c7dc3;
        K[12] = 32'h72be5d74; K[13] = 32'h80deb1fe; K[14] = 32'h9bdc06a7; K[15] = 32'hc19bf174;
        K[16] = 32'he49b69c1; K[17] = 32'hefbe4786; K[18] = 32'h0fc19dc6; K[19] = 32'h240ca1cc;
        K[20] = 32'h2de92c6f; K[21] = 32'h4a7484aa; K[22] = 32'h5cb вызывает 0a9d; K[23] = 32'h76f988da;
        K[24] = 32'h983e5152; K[25] = 32'ha831c66d; K[26] = 32'hb00327c8; K[27] = 32'hbf597fc7;
        K[28] = 32'hc6e00bf3; K[29] = 32'hd5a79147; K[30] = 32'h06ca6351; K[31] = 32'h14292967;
        K[32] = 32'h27b70a85; K[33] = 32'h2e1b2138; K[34] = 32'h4d2c6dfc; K[35] = 32'h53380d13;
        K[36] = 32'h650a7354; K[37] = 32'h766a0abb; K[38] = 32'h81c2c92e; K[39] = 32'h92722c85;
        K[40] = 32'ha2bfe8a1; K[41] = 32'ha81a664b; K[42] = 32'hc24b8b70; K[43] = 32'hc76c51a3;
        K[44] = 32'hd192e819; K[45] = 32'hd6990624; K[46] = 32'hf40e3585; K[47] = 32'h106aa070;
        K[48] = 32'h19a4c116; K[49] = 32'h1e376c08; K[50] = 32'h2748774c; K[51] = 32'h34b0bcb5;
        K[52] = 32'h391c0cb3; K[53] = 32'h4ed8aa4a; K[54] = 32'h5b9cca4f; K[55] = 32'h682e6ff3;
        K[56] = 32'h748f82ee; K[57] = 32'h78a5636f; K[58] = 32'h84c87814; K[59] = 32'h8cc70208;
        K[60] = 32'h90befffa; K[61] = 32'ha4506ceb; K[62] = 32'hbef9a3f7; K[63] = 32'hc67178f2;
    end

    // Giá trị W cho chuỗi "abc" (theo tài liệu, Hình 4.14)
    reg [31:0] W [0:63];
    initial begin
        W[0]  = 32'h61626380; // "abc" sau khi padding
        W[1]  = 32'h00000000;
        W[2]  = 32'h00000000;
        W[3]  = 32'h00000000;
        W[4]  = 32'h00000000;
        W[5]  = 32'h00000000;
        W[6]  = 32'h00000000;
        W[7]  = 32'h00000000;
        W[8]  = 32'h00000000;
        W[9]  = 32'h00000000;
        W[10] = 32'h00000000;
        W[11] = 32'h00000000;
        W[12] = 32'h00000000;
        W[13] = 32'h00000000;
        W[14] = 32'h00000000;
        W[15] = 32'h00000018; // Chiều dài của "abc" (24 bit)
        // Tính các giá trị W[16] đến W[63] theo công thức Message Scheduler
        W[16] = 32'h61626380; // Giá trị giả lập cho đơn giản (thực tế cần tính theo công thức)
        W[17] = 32'h00000000;
        W[18] = 32'h00000000;
        W[19] = 32'h00000000;
        // ... (các giá trị khác sẽ được tính trong thực tế, ở đây giả lập để minh họa)
    end

    // Mô phỏng
    integer i;
    initial begin
        // Khởi tạo tín hiệu
        reset = 1;
        start = 0;
        w_in = 0;
        k_in = 0;
        h_in = 256'h6a09e667_bb67ae85_3c6ef372_a54ff53a_510e527f_9b05688c_1f83d9ab_5be0cd19; // Giá trị H ban đầu của SHA-256
        #20;
        reset = 0;
        #10;
        start = 1;

        // Cung cấp W và K qua 64 vòng lặp
        for (i = 0; i < 64; i = i + 1) begin
            w_in = W[i];
            k_in = K[i];
            #10; // Đợi 1 chu kỳ clock
        end

        // Chờ cho đến khi hoàn thành
        wait(done);
        #20;
        $display("Kết quả mã băm: %h", h_out);
        // Kết quả mong đợi cho "abc" (theo chuẩn SHA-256):
        // ba7816bf 8f01cfea 414140de 5dae2223 b00361a3 96177a9c b410ff61 f20015ad
        $finish;
    end

    // Theo dõi tín hiệu
    initial begin
        $monitor("Time=%0t | round=%d | a=%h | e=%h | h_out=%h | done=%b", 
                 $time, uut.round, uut.a, uut.e, h_out, done);
    end

endmodule