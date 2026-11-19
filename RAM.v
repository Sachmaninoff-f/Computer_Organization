module RAM_d #(
    parameter Addr_Width = 10,
    parameter Data_Width = 16,
    parameter SIZE = 2 ** Addr_Width
) (
    input [Addr_Width - 1 : 0] Addr,
    inout [Data_Width - 1 : 0] Data,
    input RST,
    input R_W,
    input CLK,
    input CS
);
    reg [Data_Width - 1 : 0] mem [SIZE - 1 : 0];

    reg [Data_Width - 1 : 0] temp;

    integer i;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            for (i = 0; i < SIZE; i = i + 1) begin
                mem[i] <= 0;
            end
        end
        else if (CS && R_W) begin
            temp <= mem[Addr];
        end
        else if (CS && !R_W) begin
            mem[Addr] <= Data;
        end  
    end

    assign Data = (R_W && CS) ? temp : {Data_Width{1'bz}};
endmodule

module IMEM #(
    parameter Data_Width = 32,
    parameter Imem_Size = 64,
    parameter Addr_Width = $clog2(Imem_Size)
) (
    input [Addr_Width - 1 : 0] Addr,
    output [Data_Width - 1 : 0] D_out
);
    reg [Data_Width - 1 : 0] mem [Imem_Size - 1 : 0];

    assign D_out = mem[Addr];
endmodule

module REG_FILE #(
    parameter Data_Width = 32,
    parameter Addr_Width = 5,
    parameter Size = 2 ** Addr_Width
) (
    input [Addr_Width - 1 : 0] RA1, RA2, WA3,
    input CLK, WE3,
    input [Data_Width - 1 : 0] WD3,
    output [Data_Width - 1 : 0] RD1, RD2
);
    reg [Data_Width - 1 : 0] regfile [Size - 1 : 0];

    always @(posedge CLK) begin
        if (WE3) begin
            regfile[WA3] <= WD3;
        end
    end

    assign RD1 = regfile[RA1];
    assign RD2 = regfile[RA2];

endmodule
