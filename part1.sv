 //D_flip_flop
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

module T_flip_flop(
	input logic clk,
	input logic reset,
	input logic t,
	output logic q
);

	logic XOR_out;
	assign XOR_out = q ^ t;
	D_flip_flop dff(.clk (clk), .reset_b(reset), .d (XOR_out), .q(q)); 
endmodule

module part1 (
	input logic Clock,
	input logic Enable,
	input logic Reset,
	output logic [7:0] CounterValue
);

	logic [6:0] intermediate_AND_out;

	assign intermediate_AND_out[0] = Enable & CounterValue[0];
	assign intermediate_AND_out[1] = CounterValue[1] & intermediate_AND_out[0];
	assign intermediate_AND_out[2] = CounterValue[2] & intermediate_AND_out[1];
	assign intermediate_AND_out[3] = CounterValue[3] & intermediate_AND_out[2];
	assign intermediate_AND_out[4] = CounterValue[4] & intermediate_AND_out[3];
	assign intermediate_AND_out[5] = CounterValue[5] & intermediate_AND_out[4];
	assign intermediate_AND_out[6] = CounterValue[6] & intermediate_AND_out[5];


	T_flip_flop T0(.clk(Clock), .reset(Reset), .t(Enable), .q(CounterValue[0]));
	T_flip_flop T1(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[0]), .q(CounterValue[1]) );
	T_flip_flop T2(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[1]), .q(CounterValue[2]) );
	T_flip_flop T3(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[2]), .q(CounterValue[3]) );
	T_flip_flop T4(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[3]), .q(CounterValue[4]) );
	T_flip_flop T5(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[4]), .q(CounterValue[5]) );
	T_flip_flop T6(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[5]), .q(CounterValue[6]) );
	T_flip_flop T7(.clk(Clock), .reset(Reset), .t(intermediate_AND_out[6]), .q(CounterValue[7]) );

endmodule