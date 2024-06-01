`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2024 18:26:03
// Design Name: 
// Module Name: dlfloat_mult
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


module dlfloat_mult(a,b,c,clk);
    input [15:0]a,b;
    input clk;
    output  reg [15:0]c;
    
    reg [9:0]ma,mb; //1 extra because 1.smthng
    reg [8:0] mant;
    reg [19:0]m_temp; //after multiplication
    reg [5:0] ea,eb,e_temp,exp;
    reg sa,sb,s;
    reg [16:0] temp; //1 extra bit ??
    //reg [6:0] exp_adjust; //why ??

   


    always @(posedge clk)
    begin 
        ma ={1'b1,a[8:0]};
        mb= {1'b1,b[8:0]};
        sa = a[15];
        sb = b[15];
        ea = a[14:9];
        eb = b[14:9];

        e_temp = ea + eb - 31;
        m_temp = ma * mb;

        mant = m_temp[19] ? m_temp[18:10] : m_temp[17:9];
        exp = m_temp[19] ? e_temp+1'b1 : e_temp;

        s=sa ^ sb;

       c =(a==0|b==0)?0:{s,exp,mant};
    end 
endmodule 

