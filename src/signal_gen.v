// `include "./tonegen.v"
// `include "./lfsr.v"
// `include "./mixer.v"
// `include "./pwm8.v"

module signal_generator (
    input clk,              // clock 
    input write_strobe,     // strobe that controls register updates
    input [2:0] address,    // addressbus
    input [4:0] data,       // databus
    
    output signal_out,      // output for the audio signal
    output[6:0] debug       // debug-outputs
);

    reg [11:0] periodA = 12'd200;
    reg [11:0] periodB = 12'd300;
    reg [3:0] volA = 4'd8;
    reg [3:0] volB = 4'd8;
    reg [3:0] volN = 4'd3;
    
    reg enableA = 1;
    reg enableB = 1;
    reg enableN = 1;

    wire waveA;
    wire waveB;
    wire noise;
    wire [7:0] mix_level;

    tonegen tA (.clk(clk), .period(periodA), .enable(enableA), .rst(1'b0), .wave(waveA));
    tonegen tB (.clk(clk), .period(periodB), .enable(enableB), .rst(1'b0), .wave(waveB));

    lfsr n (.clk(clk), .rst(1'b0), .en_step(enableN), .noise_out(noise));

    mixer mix (
        .waveA(waveA), 
        .waveB(waveB), 
        .noise(noise), 
        .volumeA(volA), 
        .volumeB(volB), 
        .volumeNoise(volN), 
        .enableA(enableA),
        .enableB(enableB),
        .enableNoise(enableN),
        .mixout(mix_level)
    );

    pwm8 pwm (.clk(clk), .duty_cycle(mix_level), .pwm_o(signal_out));

    always @(posedge clk) begin
        if (write_strobe) begin
            case (address)
                3'b000: periodA <= {periodA[11:4], data};
                3'b001: periodB <= {periodB[11:4], data};
                3'b010: volA <= data;
                3'b011: volB <= data;
                3'b100: volN <= data;
                3'b101: {enableA, enableB, enableN} <= {data[2:0]};
                default: ;
            endcase
        end
    end
    
endmodule