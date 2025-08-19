`include "seq_detect_mealy.v"
`timescale 1ns/1ns

module tb_seq_detect_mealy;
    reg clk, rst, din;
    wire y;

    seq_detect_mealy dut(
        .clk(clk), 
        .rst(rst), 
        .din(din), 
        .y(y)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    reg [10:0] bitstream = 11'b11011011101;
    integer i;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_seq_detect_mealy);

        $display("time=%0t | din=%b | y=%b", $time, din, y);
        $monitor("time=%0t | din=%b | y=%b", $time, din, y);

        rst = 1;
        din = 0;
        #10;  
        rst = 0;

        for (i = 10; i >= 0; i = i - 1) begin
            din = bitstream[i];
            @(posedge clk); 
        end

        #20;
        $finish;
    end
endmodule