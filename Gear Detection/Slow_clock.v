module Slow_clock(input clk_in, output reg clk_out);
//assume clock freq is 50 Mhz 
	reg [22:0] count=0;
	
	always @(posedge clk_in)
	begin
	count <= count+1;
	if (count == 6_250_000) //considering 50Mhz clock 6250000 cycle will give a clock of 4Hz
	begin
	count <= 0;
	clk_out = ~clk_out;
	end
	
	end
endmodule 