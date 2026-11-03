`timescale 1ns / 1ps
module D_Trigger_tb;
    reg clk;
    reg d;
    reg rst;
    reg en;
    wire q;
    wire nq;
    D_Trigger D_Trigger_sim (
        .CLK(clk),
        .D(d),
        .RST(rst),
        .EN(en),
        .Q(q),
        .NQ(nq)
    );
    always begin
        #12;
        clk = ~clk;
    end

    initial begin
        clk = 0;
        d = 0;
        rst = 0;
        en = 0;
        #15;
        rst = 1;
        #15;
        rst = 0;
        #500;
        $finish;
    end

    always begin
        d = ~d;
        #20;
    end

    always begin
        en = ~en;
        #25;
    end
    
    initial begin
        $dumpfile("D_Trigger_wave.vcd");
        $dumpvars(0, D_Trigger_tb);
    end
endmodule



