module project_top(clk, rst, data, latch, nes_clk, timerseg1, timerseg0, pointseg1, pointseg0, buttonseg1, buttonseg0, rng, nesin);
	input clk, rst;
	input data;
	wire[7:0] point;
	reg [7:0] pointcheck;
	output latch, nes_clk;
	output  [6:0] timerseg1;
	output  [6:0] timerseg0;
	output  [6:0] pointseg1;
	output  [6:0] pointseg0;
	output  [6:0] buttonseg1;
	output  [6:0] buttonseg0;
	
	two_decimal_vals timerseg(donetime, timerseg0, timerseg1);
	two_decimal_vals pointseg(point, pointseg0, pointseg1);
	button_display buttonseg(rng, buttonseg0, buttonseg1);
	
	
	reg [2:0] s;
	
	output reg [2:0] rng;
	reg [2:0] ns;
	wire [7:0] donetime;
	reg startime;
	
	output reg [7:0] nesin;
	reg  enable;
	wire correctcheck;
	wire checkdone;
	reg lsfren;
	
	
	wire a, b, sel, star, up, down, left, right;
	wire da, db, dsel, dstart, dup, ddown, dleft, dright, drst; // debounced buttons

	nes_controller cont(clk, !rst, data, latch, nes_clk, a, b, sel, star, up, down, left, right);

	debounce a_butt(clk, a, da);
	debounce b_butt(clk, b, db);
	debounce sel_butt(clk, sel, dsel);
	debounce sta_butt(clk, star, dstart);
	debounce up_butt(clk, up, dup);
	debounce down_butt(clk, down, ddown);
	debounce left_butt(clk, left, dleft);
	debounce right_butt(clk, right, dright);
	debounce rst_butt(clk, rst, drst);

	parameter
			start = 3'b001,
			init = 3'b010,
			s1 = 3'b011,
			s2 = 3'b100,
			s3 = 3'b101,
			s4 = 3'b111,
			exit = 3'b110;
	
	
	wire nesready;
	reg [31:0] counter;
	//nes_debounce plz(clk, rst, nesin, nesready);
	timer2 check(clk, rst, startime, timerdone, donetime);
	ButtonCheck call(clk, drst, enable, rng, nesin, checkdone, point);
	wire [2:0]rand;
	
	prng lsfr(clk, drst, 3'b100,lsfren, rand);
	
	
	
	
	always @(posedge clk or negedge drst)
		 begin 
			if (drst == 1'b0)
				s <= start;
			else
				s<= ns;
		end

	always @ (*) begin
		case(s)
			start: begin if (dstart == 1'b0) ns <= start;
				else ns <= init; end
			init: ns <= s1;
			s1: begin if (donetime == 1'b1) ns<= exit;
				else ns <= s2; end
			s2:begin if (donetime == 1'b1) ns<= exit;
				else ns <= s3; end
			s3: begin if (donetime == 1'b1) ns<= exit;
				else if (checkdone == 1'b1) ns <= s4; 
				else ns<= s3; end
			s4: begin if (counter < 32'd5000000) ns <= s4;
			else ns <= s1; end
			exit: ns <= exit;
			
		endcase 
		end
		
	always @(posedge clk or negedge drst) begin
	nesin = {dright, dleft, ddown, dup, dstart, dsel, db, da}; 
		if (drst == 1'b0) begin
			startime = 0;
			counter = 32'd0;
		//	nesin = 8'd0;
			enable = 1'b0;
			rng = 3'b0;
			lsfren = 1'b0;
		//	point = 8'd0;
			
		end else begin
			case(s) 
				start: begin
					startime = 0;
					counter = 32'd0;
		//	nesin = 8'd0;
			enable = 1'b0;
			rng = 3'b0;
			lsfren = 1'b0; end
		//	point = 8'd0; end
			
			init: begin
				startime = 1;
				lsfren = 1'b1;
			end
			s1: begin // point = point + correctcheck;
			enable = 1'b0;
			counter = 32'd0;
		//	nesin = 8'd0;
			rng = 3'd0;	end
			s2: begin 
			//point = point + correctcheck;
			rng = rand;
			end
			s3: begin
			enable = 1'b1;
			
		//	nesin = {dright, dleft, ddown, dup, dstart, dsel, db, da};
			
			end
			s4: counter = counter + 32'd1;
			
			endcase
		
		end
	
	end
	
endmodule
