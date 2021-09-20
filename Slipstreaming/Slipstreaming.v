module slipstream(
	input i_clk,

	input [6:0] sweat,
	input [14:0] wind, 
  input [8:0] direction,

	output o_fan_1,
	output o_fan_2,
	output o_fan_3,
	output o_fan_4,
	output o_fan_5,
	output o_fan_6
);

	localparam SWEAT_ACTIVATION_LEVEL = 6'd50,
		SWEAT_DEACTIVATION_LEVEL = 6'd35;
		
	reg r_cooling_needed = 0;

	wire [9:0] w_fan_1_multiplier;
	wire [9:0] w_fan_2_multiplier;
	wire [9:0] w_fan_3_multiplier;
	wire [9:0] w_fan_4_multiplier;
	wire [9:0] w_fan_5_multiplier;
	wire [9:0] w_fan_6_multiplier;

	reg [19:0] r_fan_1_multiplier_half = 0;
	reg [19:0] r_fan_2_multiplier_half = 0;
	reg [19:0] r_fan_3_multiplier_half = 0;
	reg [19:0] r_fan_4_multiplier_half = 0;
	reg [19:0] r_fan_5_multiplier_half = 0;
	reg	[19:0] r_fan_6_multiplier_half = 0;
	
	reg [9:0] r_fan_1_multiplier_processed = 0;
	reg [9:0] r_fan_2_multiplier_processed = 0;
	reg [9:0] r_fan_3_multiplier_processed = 0;
	reg [9:0] r_fan_4_multiplier_processed = 0;
	reg [9:0] r_fan_5_multiplier_processed = 0;
	reg [9:0] r_fan_6_multiplier_processed = 0;
	
	reg [24:0] r_fan_1_percent_unclamped = 0; //Q9.16
	reg [24:0] r_fan_2_percent_unclamped = 0;
	reg [24:0] r_fan_3_percent_unclamped = 0;
	reg [24:0] r_fan_4_percent_unclamped = 0;
	reg [24:0] r_fan_5_percent_unclamped = 0;
	reg [24:0] r_fan_6_percent_unclamped = 0;
	
	reg [8:0] r_fan_1_percent_semi_clamped = 0;
	reg [8:0] r_fan_2_percent_semi_clamped = 0;
	reg [8:0] r_fan_3_percent_semi_clamped = 0;
	reg [8:0] r_fan_4_percent_semi_clamped = 0;
	reg [8:0] r_fan_5_percent_semi_clamped = 0;
	reg [8:0] r_fan_6_percent_semi_clamped = 0;

	reg [6:0] r_fan_1_percent = 0;
	reg [6:0] r_fan_2_percent = 0;
	reg [6:0] r_fan_3_percent = 0;
	reg [6:0] r_fan_4_percent = 0;
	reg [6:0] r_fan_5_percent = 0;
	reg [6:0] r_fan_6_percent = 0;
	
	reg [6:0] r_fan_1 = 0;
	reg [6:0] r_fan_2 = 0;
	reg [6:0] r_fan_3 = 0;
	reg [6:0] r_fan_4 = 0;
	reg [6:0] r_fan_5 = 0;
	reg [6:0] r_fan_6 = 0;

	percent_pwm fan_1_pwm_driver
	(
		.i_clk(i_clk),
		.i_divider_amount(0),
		.i_pwm_period(r_fan_1),
		.o_pwm(o_fan_1)
	);
	
	percent_pwm fan_2_pwm_driver
	(
		.i_clk(i_clk),
		.i_divider_amount(0),
		.i_pwm_period(r_fan_2),
		.o_pwm(o_fan_2)
	);
	
	percent_pwm fan_3_pwm_driver
	(
		.i_clk(i_clk),
		.i_divider_amount(0),
		.i_pwm_period(r_fan_3),
		.o_pwm(o_fan_3)
	);
	
	percent_pwm fan_4_pwm_driver
	(
		.i_clk(i_clk),
		.i_divider_amount(0),
		.i_pwm_period(r_fan_4),
		.o_pwm(o_fan_4)
	);
	
	percent_pwm fan_5_pwm_driver
	(
		.i_clk(i_clk),
		.i_divider_amount(0),
		.i_pwm_period(r_fan_5),
		.o_pwm(o_fan_5)
	);
	
	percent_pwm fan_6_pwm_driver
	(
		.i_clk(i_clk),
		.i_divider_amount(0),
		.i_pwm_period(r_fan_6),
		.o_pwm(o_fan_6)
	);
  
	fan_lut fan_lookup
	(
		.i_angle(i_wind_direction),
		.o_fan_1(w_fan_1_multiplier), // all of the fan multipliers are Q2.8
		.o_fan_2(w_fan_2_multiplier),
		.o_fan_3(w_fan_3_multiplier),
		.o_fan_4(w_fan_4_multiplier),
		.o_fan_5(w_fan_5_multiplier),
		.o_fan_6(w_fan_6_multiplier)
	);

	always @(*)
	begin
		if (r_cooling_needed == 1)
		begin
			r_cooling_needed = 1;
			
			if (i_sweat_level < SWEAT_DEACTIVATION_LEVEL)
			begin
				r_cooling_needed = 0;
			end
		end
		else
		begin
			r_cooling_needed = 0;
			
			if (i_sweat_level >= SWEAT_ACTIVATION_LEVEL)
			begin
				r_cooling_needed = 1;
			end
		end
	end

	always @(*)
	begin
		r_fan_1_multiplier_half = (w_fan_1_multiplier * 10'b0010000000);
		r_fan_2_multiplier_half = (w_fan_2_multiplier * 10'b0010000000);
		r_fan_3_multiplier_half = (w_fan_3_multiplier * 10'b0010000000);
		r_fan_4_multiplier_half = (w_fan_4_multiplier * 10'b0010000000);
		r_fan_5_multiplier_half = (w_fan_5_multiplier * 10'b0010000000);
		r_fan_6_multiplier_half = (w_fan_6_multiplier * 10'b0010000000);
	
		if (r_cooling_needed)
		begin // Q2.8 + Q2.8 = 4.16
			r_fan_1_multiplier_processed = r_fan_1_multiplier_unprocessed[17:8];
			r_fan_2_multiplier_processed = r_fan_2_multiplier_unprocessed[17:8];
			r_fan_3_multiplier_processed = r_fan_3_multiplier_unprocessed[17:8];
			r_fan_4_multiplier_processed = r_fan_4_multiplier_unprocessed[17:8];
			r_fan_5_multiplier_processed = r_fan_5_multiplier_unprocessed[17:8];
			r_fan_6_multiplier_processed = r_fan_6_multiplier_unprocessed[17:8];
		end
		else
		begin
			r_fan_1_multiplier_processed = w_fan_1_multiplier;
			r_fan_2_multiplier_processed = w_fan_2_multiplier;
			r_fan_3_multiplier_processed = w_fan_3_multiplier;
			r_fan_4_multiplier_processed = w_fan_4_multiplier;
			r_fan_5_multiplier_processed = w_fan_5_multiplier;
			r_fan_6_multiplier_processed = w_fan_6_multiplier;
		end
	end
	
	always @(*) // Q2.8 Q2.8 Q4.16
	begin
		r_fan_1_percent_unclamped = i_wind_magnitude * r_fan_1_multiplier_processed;
		r_fan_2_percent_unclamped = i_wind_magnitude * r_fan_2_multiplier_processed;
		r_fan_3_percent_unclamped = i_wind_magnitude * r_fan_3_multiplier_processed;
		r_fan_4_percent_unclamped = i_wind_magnitude * r_fan_4_multiplier_processed;
		r_fan_5_percent_unclamped = i_wind_magnitude * r_fan_5_multiplier_processed;
		r_fan_6_percent_unclamped = i_wind_magnitude * r_fan_6_multiplier_processed;
	end

	always @(*)
	begin
		r_fan_1_percent_semi_clamped = r_fan_1_percent_unclamped > (100 << 16) ? (100 << 1) : r_fan_1_percent_unclamped[15] == 1 ? {r_fan_1_percent_unclamped[23:16] + 1'b1, 1'b0} : r_fan_1_percent_unclamped[23:15];
		r_fan_2_percent_semi_clamped = r_fan_2_percent_unclamped > (100 << 16) ? (100 << 1) : r_fan_2_percent_unclamped[15] == 1 ? {r_fan_2_percent_unclamped[23:16] + 1'b1, 1'b0} : r_fan_2_percent_unclamped[23:15];
		r_fan_3_percent_semi_clamped = r_fan_3_percent_unclamped > (100 << 16) ? (100 << 1) : r_fan_3_percent_unclamped[15] == 1 ? {r_fan_3_percent_unclamped[23:16] + 1'b1, 1'b0} : r_fan_3_percent_unclamped[23:15];
		r_fan_4_percent_semi_clamped = r_fan_4_percent_unclamped > (100 << 16) ? (100 << 1) : r_fan_4_percent_unclamped[15] == 1 ? {r_fan_4_percent_unclamped[23:16] + 1'b1, 1'b0} : r_fan_4_percent_unclamped[23:15];
		r_fan_5_percent_semi_clamped = r_fan_5_percent_unclamped > (100 << 16) ? (100 << 1) : r_fan_5_percent_unclamped[15] == 1 ? {r_fan_5_percent_unclamped[23:16] + 1'b1, 1'b0} : r_fan_5_percent_unclamped[23:15];
		r_fan_6_percent_semi_clamped = r_fan_6_percent_unclamped > (100 << 16) ? (100 << 1) : r_fan_6_percent_unclamped[15] == 1 ? {r_fan_6_percent_unclamped[23:16] + 1'b1, 1'b0} : r_fan_6_percent_unclamped[23:15];
	end

	always @(*)
	begin
		r_fan_1_percent = r_fan_1_percent_semi_clamped > 100 ? 100 : r_fan_1_percent_semi_clamped[6:1];
		r_fan_2_percent = r_fan_2_percent_semi_clamped > 100 ? 100 : r_fan_2_percent_semi_clamped[6:1];
		r_fan_3_percent = r_fan_3_percent_semi_clamped > 100 ? 100 : r_fan_3_percent_semi_clamped[6:1];
		r_fan_4_percent = r_fan_4_percent_semi_clamped > 100 ? 100 : r_fan_4_percent_semi_clamped[6:1];
		r_fan_5_percent = r_fan_5_percent_semi_clamped > 100 ? 100 : r_fan_5_percent_semi_clamped[6:1];
		r_fan_6_percent = r_fan_6_percent_semi_clamped > 100 ? 100 : r_fan_6_percent_semi_clamped[6:1];
	end
	
	always @(posedge i_clk)
	begin
		if (r_cooling_needed)
		begin
			r_fan_1 = 50 + r_fan_1_percent;
			r_fan_2 = 50 + r_fan_2_percent;
			r_fan_3 = 50 + r_fan_3_percent;
			r_fan_4 = 50 + r_fan_4_percent;
			r_fan_5 = 50 + r_fan_5_percent;
			r_fan_6 = 50 + r_fan_6_percent;
		end
		else
		begin
			r_fan_1 = r_fan_1_percent;
			r_fan_2 = r_fan_2_percent;
			r_fan_3 = r_fan_3_percent;
			r_fan_4 = r_fan_4_percent;
			r_fan_5 = r_fan_5_percent;
			r_fan_6 = r_fan_6_percent;
		end
	end
endmodule
