module clock_scale (
    input clk,
    input rst,
    input [10:0] scale_factor,
    output reg clk_out
);
    reg[11:0] counter;

    always @(posedge(clk) or posedge(rst)) begin
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
    end
    
endmodule