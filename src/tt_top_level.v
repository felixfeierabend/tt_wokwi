// `include "./signal_gen.v"
// `include "./clock_scaler.v"

module tt_um_felixfeierabend (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire clk_scaled;
wire signal_bit;
wire [6:0] debug_bits;

clock_scale clk_scaler (
    .en(en)
    .clk(clk),
    .rst(~rst_n),
    .scale_factor(11'd50),
    .clk_out(clk_scaled)
);

signal_generator signal_gen (
    .clk(clk_scaled),
    .write_strobe(ui_in[0]),
    .address(uio_in[2:0]),
    .data(ui_in[7:3]),
    .signal_out(signal_bit),
    .debug(debug_bits),
    .rst(~rst_n)
);

assign uo_out = {debug_bits, signal_bit};
assign uio_oe = 8'b00000111;
assign uio_out[7:0] = 8'b00000000;

endmodule