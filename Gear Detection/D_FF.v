module D_FF(clk, reset, D, Q, Q_prime);

	input	clk,D,reset;
	output reg Q,Q_prime;
	
	always @(posedge clk, posedge reset)
	begin
	if (reset)
	Q <= 0;
	else
	Q <= D;
	Q_prime <= !Q;
	end
	
endmodule 