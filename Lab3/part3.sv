module part3(A, B, Function, ALUout);
	parameter N = 4; //add the parameter of the bit size of A and B
	input logic [N-1:0] A, B; //new N
	input logic [1:0] Function; //Not affected
	output logic [2*N - 1:0] ALUout; //variable amount

	
	//0:
	logic [2*N-1:0] case0_output;
	
	assign case0_output = A + B;

	//1:
	logic [2* N -1:0] concat;
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
				ALUout = {{(2*N-1){1'b0}}, 1'b1};
			end
			else
			begin
				ALUout = {(2*N){1'b0}};
			end
		end
	
		2:
		begin
			if (check_AND == 1)
			begin
				ALUout = {{(2*N-1){1'b0}}, 1'b1};
			end
			else
			begin
				ALUout = {(2*N){1'b0}};
			end
		end
	
		3: ALUout = concat;
		endcase
	end
			

	
endmodule