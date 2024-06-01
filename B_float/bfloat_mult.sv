`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2024 19:20:16
// Design Name: 
// Module Name: bfloat_mult
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


module bfloat_mult(a,b,c,clk);
    input [15:0]a,b;
    input clk;
    output  reg [15:0]c;
    
    reg [7:0]ma,mb; //1 extra because 1.smthng
    reg [6:0] mant;
    reg [15:0]m_temp; //after multiplication
    reg [7:0] ea,eb,e_temp,exp;
    reg sa,sb,s;
    reg [16:0] temp; //1 extra bit ??
    //reg [6:0] exp_adjust; //why ??

   


    always @(posedge clk)
    begin 
        ma ={1'b1,a[6:0]};
        mb= {1'b1,b[6:0]};
        sa = a[15];
        sb = b[15];
        ea = a[14:7];
        eb = b[14:7];

        e_temp = ea + eb - 127;
        m_temp = ma * mb;

        mant = m_temp[15] ? m_temp[14:9] : m_temp[13:8];
        exp = m_temp[15] ? e_temp+1'b1 : e_temp;

        s=sa ^ sb;

       c =(a==0|b==0)?0:{s,exp,mant};
    end 
endmodule 

