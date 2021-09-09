//timescale 1ns 
module body_position_detector_tb();

//Inputs
reg Clk,Switch_1;

//Outputs
wire LED_1;
wire [31:0] Cda;

//Instantiate the Design Under Test (DUT)
body_position DUT (.i_Clk(Clk),.i_Switch_1(Switch_1),.o_LED_1(LED_1),.o_Cda(Cda));

initial 
	begin
	Clk=0;#10;
	Switch_1=0;#10;
	Switch_1=1;#10;
	Switch_1=0;#10;
	Switch_1=1;#10;
	Switch_1=1;#10; 
	Switch_1=0;#10;
	Switch_1=0;#10;
	end
		
  //Clock 
always 
  begin
   #5 Clk = ~Clk;
  end
  
endmodule
