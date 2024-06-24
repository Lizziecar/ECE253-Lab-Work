//mux
module mux2to1(x,y,s,out);
	input logic x, y, s;
	output logic out;

	assign out = (~s & x | s & y);
endmodule

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

//register with parallel input
module muxflipflop(right, left, Loadleft, D, loadn, clock, reset, Q);
	input logic right, left, Loadleft, D, loadn, clock, reset;
	output logic Q;
	logic mux_1_output;
	logic FF_inputD;

	mux2to1 mux1(.x(right) , .y(left), .s(Loadleft), .out(mux_1_output));

	mux2to1 mux2(.x(D) , .y(mux_1_output), .s(loadn), .out(FF_inputD));

	D_flip_flop Flip_Flop(.clk(clock), .reset_b(reset), .d(FF_inputD) , .q(Q) );
endmodule

//full top level circuit
module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input logic clock, reset, ParallelLoadn, RotateRight, ASRight;
	input logic [3:0] Data_IN;
	output logic [3:0] Q;

	logic [3:0] final_output;
	logic AS_out;

	mux2to1 AS(.x(final_output[0]), .y(final_output[3]), .s(ASRight), .out(AS_out));

	muxflipflop register3(.right(final_output[2]), .left(AS_out), .Loadleft(RotateRight), .D(Data_IN[3]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(final_output[3]));
	muxflipflop register2(.right(final_output[1]), .left(final_output[3]), .Loadleft(RotateRight), .D(Data_IN[2]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(final_output[2]));
	muxflipflop register1(.right(final_output[0]), .left(final_output[2]), .Loadleft(RotateRight), .D(Data_IN[1]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(final_output[1]));
	muxflipflop register0(.right(final_output[3]), .left(final_output[1]), .Loadleft(RotateRight), .D(Data_IN[0]), .loadn(ParallelLoadn), .clock(clock), .reset(reset), .Q(final_output[0]));
	
	assign Q = final_output;
endmodule
