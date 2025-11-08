`include "signal_gen.v"

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

signal_generator signal_gen (
    .clk(clk),
    .write_strobe(uio_in[0]),
    .address(ui_in[2:0]),
    .data(ui_in[7:3]),
    .signal_out(uo_out[0]),
    .debug(uo_out[7:1])
);

assign uio_oe = 8'b00000001;

endmodule