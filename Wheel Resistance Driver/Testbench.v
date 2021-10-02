`timescale 1ns / 1ns

module wheel_resistance_driver_tb (
	input wire clk, 		//50Mhz FPGA Clock
	output out
);

reg [7:0] pwm_in = 75;

wheel_resistance_driver wrd (
	.clk(clk),
	.PWM_in(pwm_in),
	.PWM_out(out)
);

endmodule
