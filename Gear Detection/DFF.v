module D_FF(clk, D, Q, Q_prime);

	input clk,D;
	output reg 	Q,Q_prime;
	
	always @(posedge clk)
	
	begin
	Q <= D;
	Q_prime <= !Q;
	end
	
endmodule 