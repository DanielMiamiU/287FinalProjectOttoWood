`timescale 1 ps / 1 ps
module timer2(input clk, rst, en, output reg done, output reg [7:0]t);
reg [31:0]tim;

reg [2:0]S; reg [2:0]NS;
parameter start = 3'd0,
			check = 3'd1,
			timer = 3'd2,
			inc = 3'd3,
			exit = 3'd4,
			error = 3'hF;
			
			

always @(posedge clk or negedge rst) begin

	if (rst == 1'b0) begin
		S<= start;
		
		
	end else begin
		S <=NS;
	end

end
always @(*) begin
	case (S)
		start: begin if (en == 1'b0) NS <= start;
		else NS <= check; end
		check: if (t > 8'd0) NS <= timer;
				else NS <= exit;
				
		timer: if (tim < 32'd50000000) NS<= timer;
				else NS <= inc;
		inc: NS <= check;
		exit: NS <= exit;
		default: NS <= error;
	endcase

end
always @(posedge clk or negedge rst) begin

if (rst == 1'b0) begin
	t = 8'd60;
			tim = 32'd0; 
			done = 0;
end else begin
	case (S) 
		start: begin
			t = 8'd60;
			tim = 32'd0; 
			done = 0; end
			
		timer: tim = tim + 32'd1;
		inc: begin
			t = t - 8'd1;
			tim = 32'd0; end
		exit: done = 1;
	endcase
	end

end




endmodule
