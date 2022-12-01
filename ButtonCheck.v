module ButtonCheck(input clk, rst, en, input [2:0]val, input [2:0] click, output reg done);
reg [2:0] valc;
reg [2:0] S; reg [2:0] NS;
parameter start = 3'd0,
			valCheck = 3'd1,
			waiting = 3'd2,
			right = 3'd3,
			wrong = 3'd4;
			
always @(posedge clk or negedge rst) begin
	if (rst == 1'b0) S<= start;
	else S <= NS;

end
always @(*) begin
	case(S) 
		start: begin if (en == 1'b0) NS <= start;
		else NS <= valCheck; end
		valCheck: NS<= waiting;
		waiting: begin if (click == 3'd0) NS <= waiting;
		else if (click == valc) NS <= right;
		else NS <= wrong; end
		right: NS <= start;
		wrong: NS <= start;
	
	
	endcase

end

always @(posedge clk or negedge rst) begin
	if (rst == 1'b0) begin
		done = 1'b0;
	
	end else begin
		case (S) 
			start: begin
			valc = 3'd0;
			done = 1'b0; end
			valCheck: valc = val;
			right: done = 1'b1;
		endcase
	end
	

end



endmodule
