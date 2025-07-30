`timescale 1ns/1ns
`include "comp.v"

module tb;
    reg a,b;
    wire o1,o2,o3;

    comp dut(
        .A(a),
        .B(b),
        .O1(o1),
        .O2(o2),
        .O3(o3)
    );

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);

        a=0; b=0;
        #10;

        a=0;b=1;
        #10; 

        a=1; b=0;
        #10;

        a=1;b=1;
        #10; 

        $display("Test Complete...");

    end

endmodule