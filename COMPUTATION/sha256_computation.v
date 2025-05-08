module sha256_computation (
    input wire clk,
    input wire reset,
    input wire [31:0] w_in,        // Word W từ Message Scheduler
    input wire [31:0] k_in,        // Hằng số K từ K constant block
    input wire [255:0] h_in,       // Giá trị ban đầu H(0) hoặc trạng thái trước đó
    output reg [255:0] h_out,      // Kết quả mã băm sau 64 vòng lặp
    output reg done                // Tín hiệu báo hoàn thành
);

    // Thanh ghi trạng thái (a, b, c, d, e, f, g, h)
    reg [31:0] a, b, c, d, e, f, g, h;
    reg [31:0] t1, t2;
    reg [5:0] round;               // Đếm số vòng lặp (0-63)

    // Phép toán SHA-256
    function [31:0] ch;
        input [31:0] x, y, z;
        begin
            ch = (x & y) ^ (~x & z);
        end
    endfunction

    function [31:0] maj;
        input [31:0] x, y, z;
        begin
            maj = (x & y) ^ (x & z) ^ (y & z);
        end
    endfunction

    function [31:0] sigma0;
        input [31:0] x;
        begin
            sigma0 = ({x[1:0], x[31:2]} ^ {x[12:0], x[31:13]} ^ {x[21:0], x[31:22]});
        end
    endfunction

    function [31:0] sigma1;
        input [31:0] x;
        begin
            sigma1 = ({x[5:0], x[31:6]} ^ {x[10:0], x[31:11]} ^ {x[24:0], x[31:25]});
        end
    endfunction

    // Khởi tạo và cập nhật trạng thái
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Khởi tạo thanh ghi trạng thái từ giá trị H đầu vào
            a <= h_in[255:224];
            b <= h_in[223:192];
            c <= h_in[191:160];
            d <= h_in[159:128];
            e <= h_in[127:96];
            f <= h_in[95:64];
            g <= h_in[63:32];
            h <= h_in[31:0];
            round <= 0;
            done <= 0;
            h_out <= 0;
        end
        else if (round < 64) begin
            // Tính T1 và T2
            t1 = h + sigma1(e) + ch(e, f, g) + k_in + w_in;
            t2 = sigma0(a) + maj(a, b, c);

            // Cập nhật trạng thái
            h <= g;
            g <= f;
            f <= e;
            e <= d + t1;
            d <= c;
            c <= b;
            b <= a;
            a <= t1 + t2;

            round <= round + 1;
        end
        else begin
            // Khi hoàn thành 64 vòng lặp, cộng kết quả với giá trị H ban đầu
            h_out[255:224] <= h_in[255:224] + a;
            h_out[223:192] <= h_in[223:192] + b;
            h_out[191:160] <= h_in[191:160] + c;
            h_out[159:128] <= h_in[159:128] + d;
            h_out[127:96]  <= h_in[127:96]  + e;
            h_out[95:64]   <= h_in[95:64]   + f;
            h_out[63:32]   <= h_in[63:32]   + g;
            h_out[31:0]    <= h_in[31:0]    + h;
            done <= 1;
        end
    end

endmodule