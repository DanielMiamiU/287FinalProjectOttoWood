`timescale 1 ps / 1 ps
module tb;

	
	
	
	reg clk;
	reg rst;
	reg in;
	wire out;
	
	parameter simdelay = 10;
	parameter clock_delay = 5;
	fsm_question_1 DOT(clk, rst, in, out);
	
	initial
	begin
		#(simdelay) clk = 1'b0; rst = 1'b0;
		#(simdelay) rst = 1'b1;
		
		#(simdelay) in = 0;
		#(simdelay) in = 0;
		#(simdelay) in = 0;
		#(simdelay) in = 0; // on
		#(simdelay) in = 1;
		#(simdelay) in = 0;
		#(simdelay) in = 1; //on
		#(simdelay) in = 0;
		#(simdelay) in = 1; //on
		#(simdelay) in = 1;
		#(simdelay) in = 1;
		#(simdelay) in = 0;
		#(simdelay) in = 1;
		#(simdelay) in = 1;
		#(simdelay) in = 0;
		#(simdelay) in = 0;
		#(simdelay) in = 1;
		#(simdelay) in = 0;
		#(simdelay) in = 1; //0n
		#(simdelay) in = 0;
		#(simdelay) in = 0;
		#(simdelay) in = 0;
		#(simdelay) in = 1;
		#100; // let simulation finish
	
	end
	
	
	always
	begin
		#(clock_delay) clk = !clk;
	end
	
	initial
		#1000 $stop;
	
endmodule
