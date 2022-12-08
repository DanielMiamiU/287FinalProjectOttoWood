module ButtonCheck(input clk, rst, en, input [2:0]val, input [7:0] click, output reg done, output reg correct);

reg [2:0] S; reg [2:0] NS;
parameter start = 3'd0,
			valCheck = 3'd1,
			waiting = 3'd2,
			right = 3'd3,
			exit = 3'd4;
			
parameter a = 8'b00000001,
			b = 8'b00000010,
			sel = 8'b00000100,
			star = 8'b00001000,
			up = 8'b00010000,
			down = 8'b00100000,
			left = 8'b01000000,
			bright = 8'b10000000;
			

parameter acheck = 3'b001,
			bcheck = 3'b010,
			selcheck = 3'b011,
			upcheck = 3'b100,
			downcheck = 3'b101,
			leftcheck = 3'b110,
			rightcheck = 3'b111;
			
always @(posedge clk or negedge rst) begin
	if (rst == 1'b0) S<= start;
	else S <= NS;

end
always @(*) begin
	case(S) 
		start: begin if (en == 1'b0) NS <= start;
		else NS <= valCheck; end
		valCheck: NS<= waiting;
		waiting: begin if (click == 8'd0) NS <= waiting;
		else begin
			case(val)
				acheck: begin if (click == a) NS <= right;
				else NS <= exit; end
				bcheck : begin if (click == b) NS <= right;
				else NS <= exit; end
				selcheck: begin if (click == sel) NS <= right;
				else NS <= exit; end
				upcheck :begin if (click == up) NS <= right;
				else NS <= exit; end
				downcheck : begin if (click == down) NS <= right;
				else NS <= exit; end
				leftcheck :begin if (click == left) NS <= right;
				else NS <= exit; end
				rightcheck :begin if (click == bright) NS <= right;
				else NS <= exit; end
			
			endcase end
		
		end
		right: NS <= exit;
		exit: begin if (en == 1'b1) NS <= exit;
		else NS <= start; end
	
	
	endcase

end

always @(posedge clk or negedge rst) begin
	if (rst == 1'b0) begin
		done = 1'b0;
		correct = 1'b0;
	end else begin
		case (S) 
			start: begin
			done = 1'b0; 
			correct = 1'b0; end
			right: begin correct = 1'b1; end
			exit: begin done = 1'b1; correct = 1'b0; end
		endcase
	end
	

end



endmodule
