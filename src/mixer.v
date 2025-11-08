module mixer (
    input waveA,                // Channel A
    input waveB,                // Channel B
    input noise,                // LFSR-Input

    input[3:0] volumeA,         // Volume for Channel A
    input[3:0] volumeB,         // Volume for Channel B
    input[3:0] volumeNoise,     // Volume for Noise

    input enableA,              // Enable Channel A
    input enableB,              // Enable Channel B
    input enableNoise,          // Enable Noise-Channel

    output[7:0] mixout          // Mixer output for PWM
);

    // Calculate Values for channels
    wire[4:0] a_val = (enableA & waveA) ? volA : 0;
    wire[4:0] b_val = (enableB & waveB) ? volB : 0;
    wire[4:0] noise_val = (enableNoise & noise) ? volumeNoise : 0;

    // sum channels for output
    wire[5:0] sum = a_val + b_val + noise_val;

    // scale sum up to 8 bit
    assign mixout = {su,. 2'b00};
    
endmodule