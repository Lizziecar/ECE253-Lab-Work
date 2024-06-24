module hex_decoder(c, display);
	input logic [3:0]  c;
	output logic [6:0] display;

	always_comb
	begin
		case(c)
			0: display = 7'b1000000;
			1: display = 7'b1111001;
			2: display = 7'b0100100;
			3: display = 7'b0110000;
			4: display = 7'b0011001;
			5: display = 7'b0010010;
			6: display = 7'b0000010;
			7: display = 7'b1111000;
			8: display = 7'b0000000;
			9: display = 7'b0010000;
			10: display = 7'b0001000;//A
			11: display = 7'b0000011;//b
			12: display = 7'b1000110;//C
			13: display = 7'b0100001;//d
			14: display = 7'b0000110;//E
			15: display = 7'b0001110;//F
		endcase
	end	
endmodule