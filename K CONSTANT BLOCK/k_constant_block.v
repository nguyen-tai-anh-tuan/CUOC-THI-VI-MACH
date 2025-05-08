`timescale 1ns / 1ps

module k_constant_block (
    input wire clk,
    input wire reset,
    input wire [5:0] round,
    output reg [31:0] k_out
);

    // Define the 64 K constants for SHA-256 (fractional parts of cube roots of first 64 primes)
    reg [31:0] k_constants [0:63];
    initial begin
        k_constants[0]  = 32'h428a2f98;
        k_constants[1]  = 32'h71374491;
        k_constants[2]  = 32'hb5c0fbcf;
        k_constants[3]  = 32'he9b5dba5;
        k_constants[4]  = 32'h3956c25b;
        k_constants[5]  = 32'h59f111f1;
        k_constants[6]  = 32'h923f82a4;
        k_constants[7]  = 32'hab1c5ed5;
        k_constants[8]  = 32'hd807aa98;
        k_constants[9]  = 32'h12835b01;
        k_constants[10] = 32'h243185be;
        k_constants[11] = 32'h550c7dc3;
        k_constants[12] = 32'h72be5d74;
        k_constants[13] = 32'h80deb1fe;
        k_constants[14] = 32'h9bdc06a7;
        k_constants[15] = 32'hc19bf174;
        k_constants[16] = 32'he49b69c1;
        k_constants[17] = 32'hefbe4786;
        k_constants[18] = 32'h0fc19dc6;
        k_constants[19] = 32'h240ca1cc;
        k_constants[20] = 32'h2de92c6f;
        k_constants[21] = 32'h4a7484aa;
        k_constants[22] = 32'h5cb0a9dc;
        k_constants[23] = 32'h76f988da;
        k_constants[24] = 32'h983e5152;
        k_constants[25] = 32'ha831c66d;
        k_constants[26] = 32'hb00327c8;
        k_constants[27] = 32'hbf597fc7;
        k_constants[28] = 32'hc6e00bf3;
        k_constants[29] = 32'hd5a79147;
        k_constants[30] = 32'h06ca6351;
        k_constants[31] = 32'h14292967;
        k_constants[32] = 32'h27b70a85;
        k_constants[33] = 32'h2e1b2138;
        k_constants[34] = 32'h4d2c6dfc;
        k_constants[35] = 32'h53380d13;
        k_constants[36] = 32'h650a7354;
        k_constants[37] = 32'h766a0abb;
        k_constants[38] = 32'h81c2c92e;
        k_constants[39] = 32'h92722c85;
        k_constants[40] = 32'ha2bfe8a1;
        k_constants[41] = 32'ha81a664b;
        k_constants[42] = 32'hc24b8b70;
        k_constants[43] = 32'hc76c51a3;
        k_constants[44] = 32'hd192e819;
        k_constants[45] = 32'hd6990624;
        k_constants[46] = 32'hf40e3585;
        k_constants[47] = 32'h106aa070;
        k_constants[48] = 32'h19a4c116;
        k_constants[49] = 32'h1e376c08;
        k_constants[50] = 32'h2748774c;
        k_constants[51] = 32'h34b0bcb5;
        k_constants[52] = 32'h391c0cb3;
        k_constants[53] = 32'h4ed8aa4a;
        k_constants[54] = 32'h5b9cca4f;
        k_constants[55] = 32'h682e6ff3;
        k_constants[56] = 32'h748f82ee;
        k_constants[57] = 32'h78a5636f;
        k_constants[58] = 32'h84c87814;
        k_constants[59] = 32'h8cc70208;
        k_constants[60] = 32'h90befffa;
        k_constants[61] = 32'ha4506ceb;
        k_constants[62] = 32'hbef9a3f7;
        k_constants[63] = 32'hc67178f2;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            k_out <= 32'h0;
        end else begin
            k_out <= k_constants[round];
        end
    end

endmodule