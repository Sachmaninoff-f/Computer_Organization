`timescale 1ns / 1ps
module Counter_44_tb;
    reg clk;
    reg rst;
    wire [5 : 0] cnt;

    always begin
        #10;
        clk = ~clk;
    end

    Counter_44 Counter_44_sim (
        .clk(clk),
        .rst(rst),
        .C_out(cnt)
    );

    initial begin
        clk = 0;
        rst = 0;
        #10;
        rst = 1;
        #10;
        rst = 0;
        #1000;
        $finish;
    end

    initial begin
        $dumpfile("Counter_44_wave.vcd");
        $dumpvars(0, Counter_44_tb);
    end
endmodule
