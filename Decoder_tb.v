`timescale 1ns / 1ps
module Decoder_tb;
    parameter ways = 8;
    reg [$clog2(ways) - 1 : 0] data_in;
    wire [ways - 1 : 0] data_out;

    integer i;

    Decoder #(
        .ways(ways)
    ) Decoder_sim (
        .data_in(data_in),
        .data_out(data_out)
    );
    initial begin
        for (i = 0; i < ways; i = i + 1) begin
            data_in = i;
            #10;
        end
        $finish;
    end
    initial begin
        $dumpfile("Decoder_wave.vcd");
        $dumpvars(0, Decoder_tb);
    end
endmodule
