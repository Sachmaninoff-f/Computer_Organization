`timescale 1ns / 1ps
module ALU_tb;
    reg [3 : 0] op;
    parameter ways = 32;
    reg [ways - 1 : 0] a;
    reg [ways - 1 : 0] b;
    wire [ways - 1 : 0] s;
    wire zf, cf, of, sf, pf;

    ALU #(
        .ways(ways)
    ) ALU_sim (
        .OP(op),
        .A(a),
        .B(b),
        .S(s),
        .ZF(zf),
        .CF(cf),
        .OF(of),
        .SF(sf),
        .PF(pf)
    );

    initial begin
        a = 'b0;
        b = 'b0;
        op = 'b0;
    end

    always begin
        #10;
        a = a + 1;
    end

    always begin
        #12;
        b = b + 1;
    end

    always begin
        #120;
        op = op + 1;
    end

    initial begin
        #840;
        $finish;
    end

    initial begin
        $dumpfile("ALU_wave.vcd");
        $dumpvars(0, ALU_tb);
    end
endmodule