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


module part1(a, b, c_in, s, c_out);
    input logic [3:0] a,b; 
    input logic c_in;
    output logic [3:0] s, c_out;

    fullAdder u1(a[0] , b[0], c_in , s[0], c_out[0]); 
    fullAdder u2(a[1] , b[1], c_out[0] , s[1], c_out[1]);
    fullAdder u3(a[2] , b[2], c_out[1] , s[2], c_out[2]); 
    fullAdder u4(a[3] , b[3], c_out[2] , s[3], c_out[3]); 
endmodule