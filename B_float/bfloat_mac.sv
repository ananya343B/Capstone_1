`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2024 19:17:44
// Design Name: 
// Module Name: bfloat_mac
// Project Name: 
// Target Devices: 
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


module bfloat_mac(clk,rst_n,a,b,c);
    input [15:0]a,b;
    input clk,rst_n;
    output reg[15:0]c = 0;
   //reg [15:0]c_out = 0;
    reg [15:0]data_a,data_b;
    wire [15:0]fprod,fadd;
    //dlfloat_mult(a,b,c,clk);
    //dlfloat_adder(input clk, input [15:0]a, input [15:0]b, output reg [15:0]c);
    always @(posedge clk)
    begin 
    if(!rst_n)
    begin
	data_a <= 16'b0;
	data_b <= 16'b0;
	
    end 
    else 
    begin 
   data_a <= a;
   data_b <= b;
   
		
    end 
    end 
	always @(posedge clk)
		begin
			c<= fadd;
		end
	
    bfloat_mult mul(data_a,data_b,fprod,clk);
bfloat_adder add(clk,rst_n,fprod,c,fadd);

    
    //assign c = c_out;
endmodule 
