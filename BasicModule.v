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

module D_Latch (
    input CLK,
    input D,
    output reg Q, NQ,
    input RST, EN
);
    always @(*) begin
        if (RST) begin
            Q <= 0;
            NQ <= 1;
        end
        else if (EN && CLK) begin
            Q <= D;
            NQ <= ~D;
        end
    end
endmodule

module D_Trigger (
    input CLK,
    output reg Q, NQ,
    input D,
    input RST, SET, EN
);
    always @(posedge CLK or posedge RST or posedge SET) begin
        if (RST) begin
            Q <= 0;
            NQ <= 1;
        end
        else if (SET) begin
            Q <= 1;
            NQ <= 0;
        end
        else if (EN) begin
            Q <= D;
            NQ <= ~D;
        end
    end
endmodule

module Register #(
    parameter ways = 8
) (
    input [ways - 1 : 0] D_in,
    output reg [ways - 1 : 0] D_out,
    input CLK,
    input [1 : 0] S,
    input L, R,
    input RST
);
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            D_out <= 0;
        end
        else begin
            case (S) 
                2'b00: ;
                2'b01: D_out <= {L, D_out[ways - 1 : 1]};
                2'b10: D_out <= {D_out[ways - 2 : 0], R};
                2'b11: D_out <= D_in;
            endcase
        end
    end
endmodule
