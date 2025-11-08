module pwm8 (
    input clk,              // clock input
    input[7:0] duty_cycle,  // Duty cycle input
    output reg pwm_o            // pwm output
);
    reg[7:0] clk_cnt = 0;   // counter of positive clk edges

    always @(posedge clk) begin
        clk_cnt <= clk_cnt + 1;
        pwm_o <= (clk_cnt < duty_cycle);     // pwm is 1 if clk_cnt is less than duty cycle, 0 otherwise
    end
    
endmodule