//timescale 1ns / 1ns
module testbench();

//Inputs
reg clk,reset;
reg pb1,pb2;  //push-botton inputs

//Outputs
wire 	output1, output2;
wire [6:0] 	seven_segment;

// Instantiate the Design Under Test (DUT)
gear DUT (.clk(clk),.reset(reset),.gear_up(pb1),.gear_down(pb2),.out1(output1),.out2(output2),.seven_seg(seven_segment));

 initial 
	  begin
	  clk = 0;
	  reset = 0;
	  pb1 = 0;
	  pb2 = 0;
	  reset = 1;#10;
	  reset = 0;
	  
	  pb1 = 0;#50;
	  pb1 = 1;#50;
	  pb1 = 0;#50;
	  pb1 = 1;#50;
	  
	  pb2 = 0;#50;
	  pb2 = 1;#50;
	  pb2 = 0;#50;
	  pb2 = 1;#50;
	  end 

  //Clock 
 always 
  begin
   #5 clk = ~clk;
  end

endmodule 