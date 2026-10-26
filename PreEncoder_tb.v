`timescale 1ns / 1ps
module PreEncoder_tb;
    parameter ways = 8;
    reg [ways - 1 : 0] data_in;
    wire [$clog2(ways) - 1 : 0] data_out;

    integer i;

    PreEncoder #(
        .ways(ways)
    ) PreEncoder_sim (
        .data_in(data_in),
        .data_out(data_out)
    );
    initial begin
        for (i = 0; i < (1 << ways); i = i + 1) begin
            data_in = i;
            #10;
        end
        $finish;
    end
    initial begin
        $dumpfile("PreEncoder_wave.vcd");
        $dumpvars(0, PreEncoder_tb);
    end
endmodule
