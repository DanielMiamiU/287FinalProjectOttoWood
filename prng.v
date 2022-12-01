// modified lFSR from 
module prng(clk, rst, srand, init_srand, rand);
input clk, rst;
input [2:0] srand;
input init_srand;
output reg [2:0] rand;

always @(posedge clk or negedge rst) begin
	if (rst == 1'b0)
		rand <= 2'd0;
	else
		if(init_srand == 1'b0)
			rand <= srand; //This is a constant to initialize it
		else
		rand <= {rand[0]^rand[1], rand[2], rand[1]};

end
endmodule