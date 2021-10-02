// ===== Wheel Resistance Driver =====
// --- Design Doc ---
//		Description: 
//		Will control the wheel resistance of the trainer based on the wheel resistance that is sent to it 
//
//		System Integrations:
//			Input Systems (If any): 
//				Wheel Resistance Controller – will tell it the amount of wheel resistance to apply 
//
//			Output Systems (If any): 
//
//		Inputs (and what they mean): 
//			Wheel Resistance – The wheel resistance to apply 
//
//		Outputs:
//			Wheel Resistance Output - The physical system that controls the resistance
//
//		Considerations: 
//			Just like the fan driver, this will use a PWM controller. They shouldn’t be too hard to implement
//			and there are plenty of example implementations and IP cores out there to do it for us
module wheel_resistance_driver(
    input clk,
    input [7:0] PWM_in,
    output PWM_out
);

//Registers
reg [7:0] cnt;

//Incrment counter forever
always @(posedge clk) cnt <= cnt + 1'b1;

assign PWM_out = (PWM_in > cnt);

endmodule
