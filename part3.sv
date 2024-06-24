module counter_down #(parameter N = 8)
	(input logic clk,
	input logic reset,
	input logic [10:0] reset_val,
	output logic[N-1:0] q);

	always_ff @(posedge clk, posedge reset)
		if (reset) q <= reset_val;
		else	q <= q - 1;
endmodule

//Rate divider
module RateDivider
	#(parameter CLOCK_FREQUENCY = 500) (
	input logic ClockIn,
	input logic Reset,
	output logic Enable
);
	logic [26:0] N;
	logic [10:0] RateDividerCount;
	logic counter_reset;
	logic res;

	assign N = (CLOCK_FREQUENCY >> 1) - 1;	

	assign counter_reset = Reset | res;

	always_ff @(posedge ClockIn)
	begin
		if (RateDividerCount == 0)
		begin
			Enable = 1;
			res = 1;
		end
		else
		begin
			Enable = 0;
			res = 0;
		end

	end
	
	counter_down #(27) count_down(.clk(ClockIn), .reset(counter_reset), .reset_val(N), .q(RateDividerCount));
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

//mux
module mux2to1(x,y,s,out);
	input logic x, y, s;
	output logic out;

	assign out = (~s & x | s & y);
endmodule

//register with parallel input
module muxflipflop(D, parallelLoad, loadn, clock, reset, Q);
	input logic parallelLoad, D, loadn, clock, reset;
	output logic Q;

	logic FF_inputD;

	mux2to1 mux2(.x(D) , .y(parallelLoad), .s(loadn), .out(FF_inputD));

	D_flip_flop Flip_Flop(.clk(clock), .reset_b(reset), .d(FF_inputD) , .q(Q) );
endmodule

//Shift Register for 12 bits
module shiftRegister(clock, reset, Data_IN, Start, Q, shiftWire);
	input logic clock, Start, reset;
	input logic [11:0] Data_IN;
	output logic Q;

	output logic [11:1] shiftWire; 

	muxflipflop reg0(.D(0), .parallelLoad(Data_IN[0]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[1]));
	muxflipflop reg1(.D(shiftWire[1]), .parallelLoad(Data_IN[1]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[2]));
	muxflipflop reg2(.D(shiftWire[2]), .parallelLoad(Data_IN[2]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[3]));
	muxflipflop reg3(.D(shiftWire[3]), .parallelLoad(Data_IN[3]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[4]));
	muxflipflop reg4(.D(shiftWire[4]), .parallelLoad(Data_IN[4]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[5]));
	muxflipflop reg5(.D(shiftWire[5]), .parallelLoad(Data_IN[5]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[6]));
	muxflipflop reg6(.D(shiftWire[6]), .parallelLoad(Data_IN[6]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[7]));
	muxflipflop reg7(.D(shiftWire[7]), .parallelLoad(Data_IN[7]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[8]));
	muxflipflop reg8(.D(shiftWire[8]), .parallelLoad(Data_IN[8]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[9]));
	muxflipflop reg9(.D(shiftWire[9]), .parallelLoad(Data_IN[9]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[10]));
	muxflipflop reg10(.D(shiftWire[10]), .parallelLoad(Data_IN[10]), .loadn(Start), .clock(clock), .reset(reset), .Q(shiftWire[11]));
	muxflipflop reg11(.D(shiftWire[11]), .parallelLoad(Data_IN[11]), .loadn(Start), .clock(clock), .reset(reset), .Q(Q));
endmodule

module morse_code_decoder(input logic [2:0] Letter,
              output logic [11:0] morse_code_output);
    always_comb
    begin
        case(Letter)
        0: morse_code_output = 12'b010111000000;
        1: morse_code_output = 12'b011101010100;
        2: morse_code_output = 12'b011101011101;
        3: morse_code_output = 12'b011101010000;
        4: morse_code_output = 12'b010000000000;
        5: morse_code_output = 12'b010101110100;
        6: morse_code_output = 12'b011101110100;
        7: morse_code_output = 12'b010101010000;
        endcase
    end
endmodule	


module part3 #(parameter CLOCK_FREQUENCY=500)(
	input logic ClockIn,
	input logic Reset,
	input logic Start,
	input logic [2:0] Letter,
	output logic DotDashOut,
	output logic NewBitOut
);
	logic [11:0] letterMorse;
	logic [11:1] shiftWire;
	logic morseClock;
	logic RD_reset;
	assign morseClock = NewBitOut | Start;
	assign RD_reset = Reset | Start;

	RateDivider #(CLOCK_FREQUENCY) rateDiv(.ClockIn(ClockIn), .Reset(RD_reset), .Enable(NewBitOut));
	shiftRegister SR(.clock(morseClock), .reset(Reset), .Data_IN(letterMorse), .Start(Start), .Q(DotDashOut), .shiftWire(shiftWire));
	morse_code_decoder MCD(.Letter(Letter), .morse_code_output(letterMorse));

endmodule