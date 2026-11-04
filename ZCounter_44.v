module Counter_44 (
    input clk,
    input rst,
    output reg [5 : 0] C_out
);
    always @(posedge rst or posedge clk) begin
        if (rst) begin
            C_out <= 6'd0;
        end
        else begin
            if (C_out == 6'd44) begin
                C_out <= 6'd0;
            end
            else begin
                C_out <= C_out + 1'b1;
            end
        end
    end
endmodule

