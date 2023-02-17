`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/09 21:47:08
// Design Name:  booth乘法器
// Module Name: booth_top
// Project Name: 
// Target Devices: ZYNQ
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module booth_top(
	input           clk,
    input           rst_n,
    input           en,

    input[7:0]      mult_1,
    input[7:0]      mult_2,

    output[15:0]    result,
    output			result_rdy
    );
    
    wire[3:0]       rdy;
    wire[15:0]      product[3:0];
	
	wire[15:0]			mult_long;
	assign mult_long =	{{8{1'b0}},mult_2};
	booth uut0 (
    	.mult_1({mult_1[1:0],1'b0}),
    	.mult_2(mult_2),
    	.mult_pre(0),
    	.clk(clk),
    	.rst_n(rst_n),
    	.en(en),
    	.rdy(rdy[0]),
    	.mult_next(product[0])
	);
	
	booth uut1 (
    	.mult_1({mult_1[3:1]}),
    	.mult_2(mult_2),
    	.mult_pre(0),
    	.clk(clk),
    	.rst_n(rst_n),
    	.en(en),
    	.rdy(rdy[1]),
    	.mult_next(product[1])
	);
	
	booth uut2 (
    	.mult_1({mult_1[5:3]}),
    	.mult_2(mult_2),
    	.mult_pre(0),
    	.clk(clk),
    	.rst_n(rst_n),
    	.en(en),
    	.rdy(rdy[2]),
    	.mult_next(product[2])
	);
	
	booth uut3 (
    	.mult_1({mult_1[7:5]}),
    	.mult_2(mult_2),
    	.mult_pre(0),
    	.clk(clk),
    	.rst_n(rst_n),
    	.en(en),
    	.rdy(rdy[3]),
    	.mult_next(product[3])
	);
	assign result = (product[3] << 6) + (product[2] << 4) + (product[1] << 2) + product[0];
	assign result_rdy = rdy[3];
endmodule
