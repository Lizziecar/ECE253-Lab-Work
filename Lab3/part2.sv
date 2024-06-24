module mux2to1(x,y,s,out);
	input logic x, y, s;
	output logic out;

	assign out = (~s & x | s & y);
endmodule

module fullAdder(a, b, c_in, s, c_out);
	input logic a, b, c_in;
	output logic s, c_out;

	assign s = a ^ b ^ c_in;
	mux2to1 u0(.x(b), .y(c_in), .s(a^b), .out(c_out));

endmodule


module rippleAdder(a, b, c_in, s, c_out);
    input logic [3:0] a,b; 
    input logic c_in;
    output logic [3:0] s, c_out;

    fullAdder u1(a[0] , b[0], c_in , s[0], c_out[0]); 
    fullAdder u2(a[1] , b[1], c_out[0] , s[1], c_out[1]);
    fullAdder u3(a[2] , b[2], c_out[1] , s[2], c_out[2]); 
    fullAdder u4(a[3] , b[3], c_out[2] , s[3], c_out[3]); 
endmodule

module part2(A, B, Function, ALUout);
	input logic [3:0] A, B;
	input logic [1:0] Function;
	output logic [7:0] ALUout;

	
	//0:
	logic [3:0] s_adder, c_adder;
	logic [7:0] case0_output;

	rippleAdder a1(.a(A), .b(B), .c_in(0), .s(s_adder), .c_out(c_adder));
	assign case0_output = {3'b000 ,c_adder[3], s_adder};

	//1:
	logic [7:0] concat;
	logic check_OR;
	assign concat = {A,B};
	assign check_OR = |concat;  //#if there exists at least one 1 across both inputs, then the ouput to this 8-input OR gate will be 1

	//#2:
	logic check_AND;
	assign check_AND = &concat; //#the only instance where the output to this 8-input AND gate is 1, is when all 8 bits are equal to 1
	


	always_comb
	begin
		case(Function)   //#four possible s values, each one leads to a different outcome/function
		0: ALUout = case0_output;
		1: 
		begin
			if (check_OR == 1)
			begin
				ALUout = 8'b00000001;
			end
			else
			begin
				ALUout = 8'b00000000;
			end
		end
	
		2:
		begin
			if (check_AND == 1)
			begin
				ALUout = 8'b00000001;
			end
			else
			begin
				ALUout = 8'b00000000;
			end
		end
	
		3: ALUout = concat;
		endcase
	end
			

	
endmodule