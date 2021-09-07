module Debounce(slow_clk,reset,in,out);
	
	input slow_clk,in,reset;
	output out;
	wire Q1,Q2_prime;
	
	D_FF DFF1(.clk(slow_clk),.reset(reset),.D(in),.Q(Q1));
	D_FF DFF2(.clk(slow_clk),.reset(reset),.D(Q1),.Q_prime(Q2_prime));
	
	and(out,Q2_prime,Q1);

endmodule  