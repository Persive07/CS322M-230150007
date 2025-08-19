module vending_mealy(
    input wire clk,
    input wire rst, // sync active-high
    input wire [1:0] coin, // 01=5, 10=10, 00=idle
    output wire dispense,// 1-cycle pulse
    output wire chg5 // 1-cycle pulse when returning 5
);

    reg [1:0] state_present, state_next;

    parameter init = 2'b00;
    parameter s5 = 2'b01;
    parameter s10 = 2'b10;
    parameter s15 = 2'b11;

    reg dispense_reg, chg5_reg;
    assign dispense = dispense_reg;
    assign chg5 = chg5_reg;

    always @ (posedge clk) begin
        if(rst) state_present <= init;
        else state_present <= state_next;
    end

    always @ (*) begin

        // default values
        state_next = state_present;
        dispense_reg=0;
        chg5_reg=0;
        
        case(state_present) 

            init: begin
                if(coin==2'b01) state_next = s5;
                else if(coin==2'b10) state_next = s10;
            end
            
            s5: begin
                if(coin==2'b01) state_next = s10;
                else if(coin==2'b10) state_next = s15;
            end

            s10: begin
                if(coin==2'b01) state_next = s15;
                else if(coin==2'b10) begin
                    state_next = init;
                    dispense_reg=1;
                end
            end

            s15: begin
                if(coin==2'b01) begin
                    state_next = init;
                    dispense_reg=1;
                end
                else if(coin==2'b10) begin
                    state_next = init;
                    dispense_reg=1;
                    chg5_reg=1;
                end
            end

            default: begin
                state_next = init;
            end

        endcase
    end

    // assign dispense = ( ( state_present == s15 ) || (state_present == s10 && coin==2'b10) );
    // assign chg5 = ( state_present ==s15 && coin==2'b10 );


endmodule