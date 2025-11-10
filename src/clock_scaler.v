module clock_scale (
    input en,
    input clk,
    input rst,
    input [10:0] scale_factor,
    output reg clk_out
);
    reg[10:0] counter = 0;

    always @(posedge(clk)) begin
        if (en) begin
            if (rst) begin
                counter <= 10'd0;
                clk_out <= 1'b0;
            end else begin
                if (counter >= scale_factor) begin
                    counter <= 10'd0;
                    clk_out <= ~clk_out;
                end else begin
                    counter <= counter + 1;
                end
            end
        end else begin
            clk_out <= 0;
        end
    end
    
endmodule