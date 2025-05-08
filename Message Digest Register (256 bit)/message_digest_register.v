module message_digest_register (
    input wire clk,
    input wire reset,
    input wire update,
    input wire [255:0] new_digest,
    output reg [255:0] digest
);

    // Khởi tạo các giá trị băm ban đầu theo chuẩn SHA-256
    initial begin
        digest = 256'h6a09e667bb67ae853c6ef372a54ff53a510e527f9b05688c1f83d9ab5be0cd19;
    end

    // Logic cập nhật giá trị băm
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            digest <= 256'h6a09e667bb67ae853c6ef372a54ff53a510e527f9b05688c1f83d9ab5be0cd19;
        end
        else if (update) begin
            digest <= new_digest;
        end
    end

endmodule