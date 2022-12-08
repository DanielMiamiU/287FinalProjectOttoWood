module button_display(input [2:0] val, output reg [6:0]seg0, output reg [6:0]seg1);

always @(*) begin
	case(val)

	3'b001: begin seg0 = 7'b0001000; seg1= 7'b1111111; end //a
	3'b010: begin seg0 = 7'b1100000; seg1= 7'b1111111; end //b
	3'b011: begin seg0 = 7'b0110000; seg1 = 7'b0100100; end //se
	3'b100: begin seg0 = 7'b0011000; seg1 = 7'b1000001; end //up
	3'b101: begin seg0 = 7'b1000010; seg1 = 7'b1111111; end // d
	
	3'b110: begin seg0 = 7'b1110001; seg1 = 7'b1111111; end // L
	3'b111: begin seg0 = 7'b1111001; seg1 = 7'b0111001; end //ri
	default: begin seg0 = 7'b1111111; seg1= 7'b1111111; end // off
	
	endcase
end

endmodule
