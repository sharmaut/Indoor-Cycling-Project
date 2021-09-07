module GearDetection (clk, reset, gear_up, gear_down, out1, out2, seven_seg);

	input gear_up,gear_down,clk,reset; //gear_up and gear_down are the two push buttons
	output reg 	out1,out2;	//output ports for controlling other devices
	output [6:0] seven_seg;	//7 Segments display
	wire [3:0] bcd_gear;	//bcd output of gear
	wire gear_up_db,gear_down_db,slow_clk;	//debounced output of input buttons							
	
	Slow_clock Slow_Clock1	(.clk_in(clk),.clk_out(slow_clk)); //slower clock will be used for debouncing input push buttons
	Debounce DB1 (.slow_clk(slow_clk),.reset(reset),.in(gear_up),.out(gear_up_db)); //Debounce circuitry for push button 1 (gear_up)
	Debounce DB2 (.slow_clk(slow_clk),.reset(reset),.in(gear_down),.out(gear_down_db)); //Debounce circuitry for push button 2 (gear_down)
	Current_Gear gear_register (.up(gear_up_db),.down(gear_down_db),.out(bcd_gear),.clk(slow_clk),.reset(reset));
	Segments Display1 (.bcd(bcd_gear),.segment(seven_seg));
		
endmodule 