module project_top(clk, rst, in, inval, point);
	input clk, rst;
	input [1:0] in;
	input [5:0] inval;
	output reg[7:0] point;

	reg [2:0] s;
	reg [2:0] ns;
	wire [1:0] donetime;
	wire [1:0] startime;
	reg [2:0] rng;
	reg [2:0] nesin;
	reg [1:0] enable;
	wire [1:0] hold;

	parameter
			start = 3'b001,
			s0 = 3'b010,
			s1 = 3'b011,
			s2 = 3'b100,
			s3 = 3'b101,
			s4 = 3'b110,
			exit = 3'b111;


	timer2 check(clk, rst, startime , donetime);
	ButtonCheck call(clk, rst, enable, rng, nesin, hold);
	
	always @(posedge clk or negedge rst)
		 begin 
			if (rst == 1'b0)
				s <= start;
			else
				s<= ns;
		end

	always @ (*)
		case(s)
			start: 
				begin
					if (in == 1'b1)
						begin
							if (hold == 1'b1)
								point = point + 1'b1;
							else
								point = point;
							if  (donetime == 1'b1) 
								ns = exit;
							else 
								ns = s1;
						end
					else
						ns = start;
				end

			s1:
				begin
					if (in == 1'b1)
						begin
							if (hold == 1'b1)
								point = point + 1'b1;
							else
								point = point;
							if  (donetime == 1'b1) 
								ns = exit;
							else 
								ns = s2;
						end
					else
						ns = s1;
				end

			s2:
				begin
					if (in == 1'b1)
						begin
							if (hold == 1'b1)
								point = point + 1'b1;
							else
								point = point;
							if  (donetime == 1'b1) 
								ns = exit;
							else 
								ns = s3;
						end
					else
						ns = s2;
				end

			s3:
				begin
					if (in == 1'b1)
						begin
							if (hold == 1'b1)
								point = point + 1'b1;
							else
								point = point;
							if  (donetime == 1'b1) 
								ns = exit;
							else 
								ns = s4;
						end
					else
						ns = s3;
				end

			s4:
				begin
					if (in == 1'b1)
						begin
							if (hold == 1'b1)
								point = point + 1'b1;
							else
								point = point;
							if  (donetime == 1'b1) 
								ns = exit;
							else 
								ns = s1;
						end
					else
						ns = s4;
				end



			exit: if (in == 1'b1)
					begin 
						if (hold == 1'b1)
							point = point + 1'b1;
						else
							point = point;
 					end
		endcase 
endmodule
