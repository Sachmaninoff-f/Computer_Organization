`timescale 1ns / 1ps
module D_Latch_tb;
    reg clk;
    reg d;
    reg rst;
    reg en;
    wire q;
    wire nq;
    D_Latch D_Latch_sim (
        .CLK(clk),
        .D(d),
        .RST(rst),
        .EN(en),
        .Q(q),
        .NQ(nq)
    );
    always begin
        clk = ~clk;
        #10;
    end
    initial begin
        clk = 0;
        d = 0;
        en = 0;
        rst = 0;

        #10;
        d = 1;
        #20;
        en = 1;
        #20;
        en = 0;
        #20;
        d = 0;
        #20;
        rst = 1;
        #20;
        rst = 0;
        #20;
        en = 1;
        #20;
        d = 1;
        #20;
        d = 0;
        #20;
        $finish;
    end


    initial begin
        $dumpfile("D_Latch_wave.vcd");
        $dumpvars(0, D_Latch_tb);
    end
endmodule

