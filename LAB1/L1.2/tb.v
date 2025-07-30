`timescale 1ns/1ns
`include "equality.v"

module tb;
    reg [3:0] a,b;
    wire o;

    equality dut(
        .A(a),
        .B(b),
        .O(o)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);

        a = 4'b0000; b = 4'b0000;
        #10;

        a = 4'b1000; b = 4'b0001;
        #10;

        a = 4'b0110; b = 4'b0110;
        #10;

        a = 4'b1101; b = 4'b0011;
        #10;

        a = 4'b0001; b = 4'b1100;
        #10;

        a = 4'b0100; b = 4'b0100;
        #10;

        a = 4'b0111; b = 4'b1110;
        #10;

        a = 4'b1100; b = 4'b0111;
        #10;

        a = 4'b0101; b = 4'b0110;
        #10;

        a = 4'b1000; b = 4'b0011;
        #10;

        $display("test is completed...");

    end


endmodule