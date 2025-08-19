`include "vending_mealy.v"
`timescale 1ns/1ps

module tb_vending_mealy;

    reg clk;
    reg rst;
    reg [1:0] coin;
    wire dispense;
    wire chg5;

    vending_mealy dut (
        .clk(clk),
        .rst(rst),
        .coin(coin),
        .dispense(dispense),
        .chg5(chg5)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_vending_mealy);

        clk = 0;
        rst = 1;
        coin = 2'b00;

        // Hold reset
        #10;
        rst = 0;

        // Insert 5, 5, 10 => total = 20 => dispense
        #10 coin = 2'b01; // insert 5
        #10 coin = 2'b01; // insert 5
        #10 coin = 2'b10; // insert 10
        #10 coin = 2'b00; // idle

        // Insert 10, 10 => total = 20 => dispense
        #10 coin = 2'b10; // insert 10
        #10 coin = 2'b10; // insert 10
        #10 coin = 2'b00;

        // Insert 10, 5, 10 => total = 25 => dispense + change
        #10 coin = 2'b10; // insert 10
        #10 coin = 2'b01; // insert 5
        #10 coin = 2'b10; // insert 10
        #10 coin = 2'b00;

        // Finish
        #50 $finish;
    end

endmodule