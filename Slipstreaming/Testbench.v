// Testbench for testing slipstream_processor

`timescale 1ns/1ns

module slipstream_processor_tb;
	
	`include "../../../misc/tb_functions/assert_display.v"
	
	// Inputs
	// Range 0 - 359 (360+ means no obstruction)
	reg [8:0] t_angle = 0;
	
	// Range 0 - 100
	reg [6:0] t_in_fan_1 = 0;
	reg [6:0] t_in_fan_2 = 0;
	reg [6:0] t_in_fan_3 = 0;
	reg [6:0] t_in_fan_4 = 0;
	reg [6:0] t_in_fan_5 = 0;
	reg [6:0] t_in_fan_6 = 0;
	
	// Outputs
	wire [6:0] t_out_fan_1;
	wire [6:0] t_out_fan_2;
	wire [6:0] t_out_fan_3;
	wire [6:0] t_out_fan_4;
	wire [6:0] t_out_fan_5;
	wire [6:0] t_out_fan_6;
	
	// Instantiate the Unit Under Test (UUT)
	slipstream_processor UUT
	(
		.i_angle(t_angle),
		.i_fan_1(t_in_fan_1),
		.i_fan_2(t_in_fan_2),
		.i_fan_3(t_in_fan_3),
		.i_fan_4(t_in_fan_4),
		.i_fan_5(t_in_fan_5),
		.i_fan_6(t_in_fan_6),
		.o_fan_1(t_out_fan_1),
		.o_fan_2(t_out_fan_2),
		.o_fan_3(t_out_fan_3),
		.o_fan_4(t_out_fan_4),
		.o_fan_5(t_out_fan_5),
		.o_fan_6(t_out_fan_6)
	);
	
	initial
	begin
		
		$dumpfile("out.vcd");
		$dumpvars(1, slipstream_processor_tb);
		$timeformat(-9, 0, " ns", 20);
		
		$display("Starting Tests...");
		
		#2
		
		$display("Setting all fans to 100...");
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		#1
		
		// Test 0
		$display("Test 0: Checking that at 0 angle, fan 1 and fan 2 are running at 13 % speed. Rest are fully on.");
		
		
		t_angle = 9'd30;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd0);
		assert_unit(t_out_fan_2 == 7'd50);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd100);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd50);
		
		
		
		
		// Test 1
		$display("Test 1: Checking that at 30 angle, the first fan is blocked, and the two fans either side of it are half blocked");
		
		
		t_angle = 9'd30;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd0);
		assert_unit(t_out_fan_2 == 7'd50);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd100);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd50);
		
		// Test 2
		$display("Test 2: Checking that at 60 angle, fan1 and fan6 are running at 13% speed,rest of the fans are fully on");
		$display("Note: This might need to be changed to be only the first fan");
		
		t_angle = 9'd60;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd13);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd100);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd13);
		
		// Test 3
		$display("Test 3: Checking that at 90 angle, fan 6 is blocked, fan 1 and fan 5 are half blocked, fan 2 ,fan 3 and fan 4 are fully on");
		
		t_angle = 9'd90;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd50);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd100);
		assert_unit(t_out_fan_5 == 7'd50);
		assert_unit(t_out_fan_6 == 7'd0);
		
		// Test 4
		$display("Test 4: Checking that at 120 angle, fan 5 and fan 6 are running at 13 % speed, fan 1, fan 2, fan 3 and fan 4 are fully on");
		$display("Note: This might need to be changed to be only the first fan");
		
		t_angle = 9'd120;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd100);
		assert_unit(t_out_fan_5 == 7'd13);
		assert_unit(t_out_fan_6 == 7'd13);
		
		
		// Test 5
		
		$display("Test 5: Checking that at 150 angle, fan 5 is blocked, fan 4 and fan 6 are half blocked");
	
		t_angle = 9'd150;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd50);
		assert_unit(t_out_fan_5 == 7'd0);
		assert_unit(t_out_fan_6 == 7'd50);
		
		
		// Test 6
		$display("Test 6: Checking that at 180 angle, fan 4 and fan 5 are running at 13 % speed. Rest all are fully on");
		
		t_angle = 9'd180;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd13);
		assert_unit(t_out_fan_5 == 7'd13);
		assert_unit(t_out_fan_6 == 7'd100);
		
		// Test 7
		
		$display("Test 7: Checking that at 210 angle, fan 4 is blocked, fan 3 and fan 5 are half blocked.");
		
		t_angle = 9'd210;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd50);
		assert_unit(t_out_fan_4 == 7'd0);
		assert_unit(t_out_fan_5 == 7'd50);
		assert_unit(t_out_fan_6 == 7'd100);
		
		
		// Test 8
		$display("Test 8: Checking that at 240 angle, fan 3 and fan 4 are running at 13 % speed.");
		
		t_angle = 9'd240;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd13);
		assert_unit(t_out_fan_4 == 7'd13);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd100);
		
		// Test 9
		$display("Test 9: Checking that at 270 angle, fan 3 is blocked, fan 2 and fan 4 are half blocked.");
		
		t_angle = 9'd270;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd50);
		assert_unit(t_out_fan_3 == 7'd0);
		assert_unit(t_out_fan_4 == 7'd50);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd100);
		
		
		// Test 10
		
		$display("Test 10: Checking that at 300 angle, fan 2 and fan 3 are running at 13 % speed. Rest are fully on");
		
		t_angle = 9'd300;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd13);
		assert_unit(t_out_fan_3 == 7'd13);
		assert_unit(t_out_fan_4 == 7'd99);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd100);
		
		
		// Test 11
		$display("Test 11: Checking that at 330 angle, fan 2 is blocked, fan 1 and fan 3 is half blocked. fan 4 is running at 14 % speed");
		
		t_angle = 9'd330;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd50);
		assert_unit(t_out_fan_2 == 7'd0);
		assert_unit(t_out_fan_3 == 7'd50);
		assert_unit(t_out_fan_4 == 7'd14);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd100);
		
		
		// Test 12
		$display("Test 12: Checking that at 360 angle, all the fans are fully on");
		
		t_angle = 9'd360;
		t_in_fan_1 = 7'd100;
		t_in_fan_2 = 7'd100;
		t_in_fan_3 = 7'd100;
		t_in_fan_4 = 7'd100;
		t_in_fan_5 = 7'd100;
		t_in_fan_6 = 7'd100;
		
		assert_unit(t_out_fan_1 == 7'd100);
		assert_unit(t_out_fan_2 == 7'd100);
		assert_unit(t_out_fan_3 == 7'd100);
		assert_unit(t_out_fan_4 == 7'd100);
		assert_unit(t_out_fan_5 == 7'd100);
		assert_unit(t_out_fan_6 == 7'd100);
		
		
		
		#10;
		assert_unit_stop();
	end
	
endmodule
