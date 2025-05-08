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
            case (addr)
                0:  if (k_out !== 32'h428a2f98) $display("Error at addr %d, expected 428a2f98, got %h", addr, k_out);
                1:  if (k_out !== 32'h71374491) $display("Error at addr %d, expected 71374491, got %h", addr, k_out);
                2:  if (k_out !== 32'hb5c0fbcf) $display("Error at addr %d, expected b5c0fbcf, got %h", addr, k_out);
                3:  if (k_out !== 32'he9b5dba5) $display("Error at addr %d, expected e9b5dba5, got %h", addr, k_out);
                4:  if (k_out !== 32'h3956c25b) $display("Error at addr %d, expected 3956c25b, got %h", addr, k_out);
                5:  if (k_out !== 32'h59f111f1) $display("Error at addr %d, expected 59f111f1, got %h", addr, k_out);
                6:  if (k_out !== 32'h923f82a4) $display("Error at addr %d, expected 923f82a4, got %h", addr, k_out);
                7:  if (k_out !== 32'hab1c5ed5) $display("Error at addr %d, expected ab1c5ed5, got %h", addr, k_out);
                8:  if (k_out !== 32'hd807aa98) $display("Error at addr %d, expected d807aa98, got %h", addr, k_out);
                9:  if (k_out !== 32'h12835b01) $display("Error at addr %d, expected 12835b01, got %h", addr, k_out);
                10: if (k_out !== 32'h243185be) $display("Error at addr %d, expected 243185be, got %h", addr, k_out);
                11: if (k_out !== 32'h550c7dc3) $display("Error at addr %d, expected 550c7dc3, got %h", addr, k_out);
                12: if (k_out !== 32'h72be5d74) $display("Error at addr %d, expected 72be5d74, got %h", addr, k_out);
                13: if (k_out !== 32'h80deb1fe) $display("Error at addr %d, expected 80deb1fe, got %h", addr, k_out);
                14: if (k_out !== 32'h9bdc06a7) $display("Error at addr %d, expected 9bdc06a7, got %h", addr, k_out);
                15: if (k_out !== 32'hc19bf174) $display("Error at addr %d, expected c19bf174, got %h", addr, k_out);
                16: if (k_out !== 32'he49b69c1) $display("Error at addr %d, expected e49b69c1, got %h", addr, k_out);
                17: if (k_out !== 32'hefbe4786) $display("Error at addr %d, expected efbe4786, got %h", addr, k_out);
                18: if (k_out !== 32'h0fc19dc6) $display("Error at addr %d, expected 0fc19dc6, got %h", addr, k_out);
                19: if (k_out !== 32'h240ca1cc) $display("Error at addr %d, expected 240ca1cc, got %h", addr, k_out);
                20: if (k_out !== 32'h2de92c6f) $display("Error at addr %d, expected 2de92c6f, got %h", addr, k_out);
                21: if (k_out !== 32'h4a7484aa) $display("Error at addr %d, expected 4a7484aa, got %h", addr, k_out);
                22: if (k_out !== 32'h5cb0a9dc) $display("Error at addr %d, expected 5cb0a9dc, got %h", addr, k_out);
                23: if (k_out !== 32'h76f988da) $display("Error at addr %d, expected 76f988da, got %h", addr, k_out);
                24: if (k_out !== 32'h983e5152) $display("Error at addr %d, expected 983e5152, got %h", addr, k_out);
                25: if (k_out !== 32'ha831c66d) $display("Error at addr %d, expected a831c66d, got %h", addr, k_out);
                26: if (k_out !== 32'hb00327c8) $display("Error at addr %d, expected b00327c8, got %h", addr, k_out);
                27: if (k_out !== 32'hbf597fc7) $display("Error at addr %d, expected bf597fc7, got %h", addr, k_out);
                28: if (k_out !== 32'hc6e00bf3) $display("Error at addr %d, expected c6e00bf3, got %h", addr, k_out);
                29: if (k_out !== 32'hd5a79147) $display("Error at addr %d, expected d5a79147, got %h", addr, k_out);
                30: if (k_out !== 32'h06ca6351) $display("Error at addr %d, expected 06ca6351, got %h", addr, k_out);
                31: if (k_out !== 32'h14292967) $display("Error at addr %d, expected 14292967, got %h", addr, k_out);
                32: if (k_out !== 32'h27b70a85) $display("Error at addr %d, expected 27b70a85, got %h", addr, k_out);
                33: if (k_out !== 32'h2e1b2138) $display("Error at addr %d, expected 2e1b2138, got %h", addr, k_out);
                34: if (k_out !== 32'h4d2c6dfc) $display("Error at addr %d, expected 4d2c6dfc, got %h", addr, k_out);
                35: if (k_out !== 32'h53380d13) $display("Error at addr %d, expected 53380d13, got %h", addr, k_out);
                36: if (k_out !== 32'h650a7354) $display("Error at addr %d, expected 650a7354, got %h", addr, k_out);
                37: if (k_out !== 32'h766a0abb) $display("Error at addr %d, expected 766a0abb, got %h", addr, k_out);
                38: if (k_out !== 32'h81c2c92e) $display("Error at addr %d, expected 81c2c92e, got %h", addr, k_out);
                39: if (k_out !== 32'h92722c85) $display("Error at addr %d, expected 92722c85, got %h", addr, k_out);
                40: if (k_out !== 32'ha2bfe8a1) $display("Error at addr %d, expected a2bfe8a1, got %h", addr, k_out);
                41: if (k_out !== 32'ha81a664b) $display("Error at addr %d, expected a81a664b, got %h", addr, k_out);
                42: if (k_out !== 32'hc24b8b70) $display("Error at addr %d, expected c24b8b70, got %h", addr, k_out);
                43: if (k_out !== 32'hc76c51a3) $display("Error at addr %d, expected c76c51a3, got %h", addr, k_out);
                44: if (k_out !== 32'hd192e819) $display("Error at addr %d, expected d192e819, got %h", addr, k_out);
                45: if (k_out !== 32'hd6990624) $display("Error at addr %d, expected d6990624, got %h", addr, k_out);
                46: if (k_out !== 32'hf40e3585) $display("Error at addr %d, expected f40e3585, got %h", addr, k_out);
                47: if (k_out !== 32'h106aa070) $display("Error at addr %d, expected 106aa070, got %h", addr, k_out);
                48: if (k_out !== 32'h19a4c116) $display("Error at addr %d, expected 19a4c116, got %h", addr, k_out);
                49: if (k_out !== 32'h1e376c08) $display("Error at addr %d, expected 1e376c08, got %h", addr, k_out);
                50: if (k_out !== 32'h2748774c) $display("Error at addr %d, expected 2748774c, got %h", addr, k_out);
                51: if (k_out !== 32'h34b0bcb5) $display("Error at addr %d, expected 34b0bcb5, got %h", addr, k_out);
                52: if (k_out !== 32'h391c0cb3) $display("Error at addr %d, expected 391c0cb3, got %h", addr, k_out);
                53: if (k_out !== 32'h4ed8aa4a) $display("Error at addr %d, expected 4ed8aa4a, got %h", addr, k_out);
                54: if (k_out !== 32'h5b9cca4f) $display("Error at addr %d, expected 5b9cca4f, got %h", addr, k_out);
                55: if (k_out !== 32'h682e6ff3) $display("Error at addr %d, expected 682e6ff3, got %h", addr, k_out);
                56: if (k_out !== 32'h748f82ee) $display("Error at addr %d, expected 748f82ee, got %h", addr, k_out);
                57: if (k_out !== 32'h78a5636f) $display("Error at addr %d, expected 78a5636f, got %h", addr, k_out);
                58: if (k_out !== 32'h84c87814) $display("Error at addr %d, expected 84c87814, got %h", addr, k_out);
                59: if (k_out !== 32'h8cc70208) $display("Error at addr %d, expected 8cc70208, got %h", addr, k_out);
                60: if (k_out !== 32'h90befffa) $display("Error at addr %d, expected 90befffa, got %h", addr, k_out);
                61: if (k_out !== 32'ha4506ceb) $display("Error at addr %d, expected a4506ceb, got %h", addr, k_out);
                62: if (k_out !== 32'hbef9a3f7) $display("Error at addr %d, expected bef9a3f7, got %h", addr, k_out);
                63: if (k_out !== 32'hc67178f2) $display("Error at addr %d, expected c67178f2, got %h", addr, k_out);
                default: $display("Addr out of range: %d", addr);
            endcase
        end

        // Kết thúc mô phỏng
        #50 $finish;
    end

endmodule