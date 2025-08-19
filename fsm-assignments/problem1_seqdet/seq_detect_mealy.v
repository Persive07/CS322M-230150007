module seq_detect_mealy(
    input wire clk,
    input wire rst,   // sync active-high
    input wire din,   // serial input bit per clock
    output wire y     // 1-cycle pulse when pattern ...1101 seen
);
    reg [1:0] state_present, state_next;

    parameter init = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;
    parameter s3 = 2'b11;

    always @ (posedge clk) begin
        if(rst) state_present <= init;
        else state_present <= state_next;
    end
    
    always @ (*) begin
        case(state_present) 

            init: begin
                if(din) state_next = s1;
                else state_next = init;
            end
            
            s1: begin
                if(din) state_next = s2;
                else state_next = init;
            end

            s2: begin
                if(din) state_next = s2;
                else state_next = s3;
            end

            s3: begin
                if(din) state_next = s1;
                else state_next = init;
            end

            default: begin
                state_next = init;
            end

        endcase
    end

    assign y = (state_present == s3 && din == 1'b1);
            
endmodule