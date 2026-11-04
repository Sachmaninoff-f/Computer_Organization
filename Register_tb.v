`timescale 1ns / 1ps
module Register_tb ();
    parameter ways = 8;
    reg [ways - 1 : 0] D_in;
    wire [ways - 1 : 0] D_out;
    reg clk;
    reg [1 : 0] s;
    reg l;
    reg r;
    reg rst;

    Register #(
        .ways(ways)
    ) Register_sim (
        .D_in(D_in),
        .D_out(D_out),
        .CLK(clk),
        .S(s),
        .R(r),
        .L(l),
        .RST(rst)
    );
    
    always begin
        #10;
        clk = ~clk;
    end

    initial begin
        clk = 0;
        D_in = 0;
        s = 0;
        r = 0;
        l = 0;
        rst = 0;
        #10;

        rst = 1;
        #20;
        rst = 0;
        #10;
        #800;
        $finish;
    end

    integer i;
    always begin
        for (i = 0; i < (1 << ways); i = i + 1) begin
            D_in = i;
            #7;
        end
    end

    always begin
        s = 0;
        #100;
        s = 3;
        #100;
        s = 0;
        #100;
        s = 1;
        #100;
        s = 2;
        #100;
        s = 3;
    end

    initial begin
        $dumpfile("Register_wave.vcd");
        $dumpvars(0, Register_sim);
    end
endmodule
