module two_decimal_vals (
input [7:0]val,
output [6:0]seg7_lsb,
output [6:0]seg7_msb
); 

reg [3:0] result_one_digit;
reg [3:0] result_ten_digit;



reg [7:0]twos_comp;

/* convert the binary value into 3 signals of negative, one and ten digit */
always @(*)
begin
	twos_comp = val;
	
//	result_one_digit = twos_comp % 10;
//	twos_comp = (twos_comp - (twos_comp % 10)) / 10;
//	result_ten_digit = twos_comp % 10;
//	twos_comp = (twos_comp - (twos_comp % 10)) / 10;
//	result_hund_digit = twos_comp;
	
	result_one_digit = twos_comp%10;
	result_ten_digit = (twos_comp/10)%10;
	
	
end

/* instantiate the modules for each of the seven seg decoders including the negative one */
seven_segment lsb (result_one_digit, seg7_lsb);
seven_segment midb (result_ten_digit, seg7_msb);



endmodule
