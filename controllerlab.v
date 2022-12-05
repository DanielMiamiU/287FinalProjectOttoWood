module controllerlab(input clk, rst, pen,en, data, pclk, output latch, nes_clk, led0, output reg led1, led2, led3, led4, led5, led6, led7, led8, output reg[2:0]z);

wire a, b, sel, start, up, down, left, right;
wire da, db, dsel, dstart, dup, ddown, dleft, dright; // debounced buttons

nes_controller cont(clk, !rst, data, latch, nes_clk, a, b, sel, start, up, down, left, right);

debouncer a_butt(clk, a, da);
debouncer b_butt(clk, b, db);
debouncer sel_butt(clk, sel, dsel);
debouncer sta_butt(clk, start, dstart);
debouncer up_butt(clk, up, dup);
debouncer down_butt(clk, down, ddown);
debouncer left_butt(clk, left, dleft);
debouncer right_butt(clk, right, dright);

reg [7:0]controller;
always @(*)
	begin
	controller = {dright, dleft, ddown, dup, dstart, dsel, db, da};
	led1 <= controller[0];
	led2 <= controller[1];
	led3 <= controller[2];
	led4 <= controller[3];
	led5 <= controller[4];
	led6 <= controller[5];
	led7 <= controller[6];
	led8 <= controller[7];
	if(pclk == 1'b1)
		z <= rand;
else 
	z <= z;
end


wire [2:0]rand; 
prng rng(clk, rst, 3'b100, pen, rand);
ButtonCheck game(clk, rst, en, z, controller, led0);
 


endmodule
