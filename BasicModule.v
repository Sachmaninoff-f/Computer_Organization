module MUX #(
    parameter ways = 4
) (
    input wire [ways - 1 : 0] data_in,
    input wire [$clog2(ways) - 1 : 0] sel,
    output wire data_out
);
    assign data_out = data_in[sel];
endmodule

module PreEncoder #(
    parameter ways = 8
) (
    input wire [ways - 1 : 0] data_in,
    output reg [$clog2(ways) - 1 : 0] data_out
);
    reg flag;
    integer i;
    always @(*) begin
        flag = 0;
        i = 0;
        data_out = 0;
        for (i = ways - 1; i >= 0; i = i - 1)  begin
            if (!flag) begin
                if (data_in[i]) begin
                    flag = 1;
                    data_out = i;
                end
            end
        end
    end
endmodule

module Decoder #(
    parameter ways = 8
) (
    input wire [$clog2(ways) - 1 : 0] data_in,
    output wire [ways - 1 : 0] data_out
);
    assign data_out = 1'b1 << data_in;
endmodule
