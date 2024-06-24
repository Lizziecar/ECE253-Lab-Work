//inverter
module v7404 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1, pin3, pin5, pin9, pin11, pin13;
	output logic pin2, pin4, pin6, pin8, pin10, pin12;
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;

endmodule

//AND
module v7408 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1, pin2, pin4, pin5, pin9, pin10, pin13, pin12;
	output logic pin3, pin6, pin8, pin11;
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;

endmodule

//OR
module v7432 (pin1, pin3, pin5, pin9, pin11, pin13, pin2, pin4, pin6, pin8, pin10, pin12);
	input logic pin1, pin2, pin4, pin5, pin9, pin10, pin13, pin12;
	output logic pin3, pin6, pin8, pin11;

	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;
endmodule

module mux2to1(x, y, s, m);
	input logic x, y, s;
	output logic m;
	
	logic outNOT;
	logic outAND1;
	logic outAND2;

	v7404 NOT(.pin1(s), .pin2(outNOT));
	v7408 AND(.pin1(x), .pin2(outNOT), .pin3(outAND1), .pin4(s), .pin5(y), .pin6(outAND2));
	v7432 OR(.pin1(outAND1), .pin2(outAND2), .pin3(m));
	
endmodule