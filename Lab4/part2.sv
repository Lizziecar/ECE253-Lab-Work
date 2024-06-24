module D_flip_flop(
	input logic clk,
	input logic reset_b,
	input logic d,
	output logic q
);
	always_ff @(posedge clk)
	begin
		if (reset_b) q <= 1'b0;
		else q <= d;
	end
endmodule

module ALU(Data_A, Data_B, Function, output_8);
	input logic [3:0] Data_A, Data_B;
	input logic [1:0] Function;
	output logic [7:0] output_8;

	always_comb
	begin
		case(Function)
		0: output_8 = Data_A + Data_B;
		1: output_8 = Data_A * Data_B;
		2: output_8 = Data_B << Data_A;
		3: output_8[3:0] = Data_B;
		default: output_8[3:0] = Data_B;
		endcase
	end
endmodule


//High level Module
module part2(Clock, Reset_b, Data, Function, ALUout);
	input logic Clock, Reset_b;
	input logic [3:0] Data;
	input logic [1:0] Function;
	output logic [7:0] ALUout;
	
	logic [7:0] betweenVal;
	logic [7:0] finalVal; 

	ALU adder(.Data_A(Data), .Data_B(finalVal[3:0]), .Function(Function), .output_8(betweenVal));
	D_flip_flop d0(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[0]), .q(finalVal[0]));
	D_flip_flop d1(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[1]), .q(finalVal[1]));
	D_flip_flop d2(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[2]), .q(finalVal[2]));
	D_flip_flop d3(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[3]), .q(finalVal[3]));
	D_flip_flop d4(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[4]), .q(finalVal[4]));
	D_flip_flop d5(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[5]), .q(finalVal[5]));
	D_flip_flop d6(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[6]), .q(finalVal[6]));
	D_flip_flop d7(.clk(Clock), .reset_b(Reset_b), .d(betweenVal[7]), .q(finalVal[7]));
	
	assign ALUout = finalVal;
	
endmodule

	
	