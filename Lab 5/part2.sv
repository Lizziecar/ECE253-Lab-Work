module counter_down #(parameter N = 8)
	(input logic clk,
	input logic reset,
	input logic [10:0] reset_val,
	output logic[N-1:0] q);

	always_ff @(posedge clk)
		if (reset) q <= reset_val;
		else	q <= q - 1;
endmodule

module counter_up #(parameter N = 8)
	(input logic clk,
	 input logic reset,
	 input logic enable,
	 output logic[N-1:0] q);

	always_ff @(posedge clk)
		if (reset) q <= 0;
		else if (enable)	q <= q + 1;
endmodule

module RateDivider
	#(parameter CLOCK_FREQUENCY = 500) (
	input logic ClockIn,
	input logic Reset,
	input logic [1:0] Speed,
	output logic Enable
);
	logic [10:0] N; //max number of bits required at any point (500/0.25) gives 2000; 10 bits
	logic [10:0] RateDividerCount;
	logic counter_reset;
	logic res;	

	assign counter_reset = Reset | res;
	
	always_comb
	begin
		case(Speed)
			0:N = 0;
			1:N = CLOCK_FREQUENCY;	      //N * 1
			2:N = CLOCK_FREQUENCY << 1;   //N * 2
			3:N = CLOCK_FREQUENCY << 2;   //N * 4
		endcase
		
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
	
	counter_down #(11) count_down(.clk(ClockIn), .reset(counter_reset), .reset_val(N), .q(RateDividerCount));
endmodule

module DisplayCounter(
	input logic Clock,
	input logic Reset,
	input logic EnableDC,
	output logic [3:0] CounterValue
);
	counter_up #(4) dis_count(.clk(Clock), .reset(Reset), .enable(EnableDC), .q(CounterValue));
endmodule

module part2 #(parameter CLOCK_FREQUENCY = 500)(
	input logic ClockIn,
	input logic Reset,
	input logic [1:0] Speed,
	output logic [3:0] CounterValue
);
	logic EnableWire;
	RateDivider #(CLOCK_FREQUENCY) RD(.ClockIn(ClockIn), .Reset(Reset), .Speed(Speed), .Enable(EnableWire));
	DisplayCounter CE(.Clock(ClockIn), .Reset(Reset), .EnableDC(EnableWire), .CounterValue(CounterValue));
endmodule


