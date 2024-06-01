`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2024 18:26:59
// Design Name: 
// Module Name: dlfloat_adder
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


module dlfloat_adder(input clk,input rst_n, input [15:0]a, input [15:0]b, output reg [15:0]c);
    
    reg    [15:0] Num_shift_80; 
    reg    [5:0]  Larger_exp_80,Final_expo_80;
    reg    [8:0] Small_exp_mantissa_80,S_mantissa_80,L_mantissa_80,Large_mantissa_80,Final_mant_80;
    reg    [9:0] Add_mant_80,Add1_mant_80;
    reg    [5:0]  e1_80,e2_80;
    reg    [8:0] m1_80,m2_80;
    reg          s1_80,s2_80,Final_sign_80;
    reg    [3:0]  renorm_shift_80;
    integer signed   renorm_exp_80;
    //reg           renorm_exp_80;
    reg    [15:0] c_80;


	always @(posedge clk)
	begin 
	if(!rst_n)
	begin 
	c <= 0;
	end 
	else 
	begin 
	c <= c_80;
	end 
	end 
			
   // assign c = c_80;
    


    always @(*) begin
        //stage 1
	e1_80 = a[14:9];
	e2_80 = b[14:9];
        m1_80 = a[8:0];
	m2_80 = b[8:0];
	s1_80 = a[15];
	s2_80 = b[15];
        
        if (e1_80  > e2_80) begin
            Num_shift_80           = e1_80 - e2_80;              // number of mantissa shift
            Larger_exp_80           = e1_80;                     // store lower exponent
            Small_exp_mantissa_80  = m2_80;
            Large_mantissa_80      = m1_80;
        end
        
        else begin
            Num_shift_80           = e2_80 - e1_80;
            Larger_exp_80           = e2_80;
            Small_exp_mantissa_80  = m1_80;
            Large_mantissa_80      = m2_80;
        end

	if (e1_80 == 0 | e2_80 ==0) begin
	    Num_shift_80 = 0;
	end
	else begin
	    Num_shift_80 = Num_shift_80;
	end
	
	
        
        //stage 2
        //if check both for normalization then append 1 and shift
	if (e1_80 != 0) begin
            Small_exp_mantissa_80  = {1'b1,Small_exp_mantissa_80[8:1]};
	    Small_exp_mantissa_80  = (Small_exp_mantissa_80 >> Num_shift_80);
        end
	else begin
	    Small_exp_mantissa_80 = Small_exp_mantissa_80;
	end

	if (e2_80!= 0) begin
            Large_mantissa_80      = {1'b1,Large_mantissa_80[8:1]};
	end
	else begin
	    Large_mantissa_80 = Large_mantissa_80;
	end

        	//else do what to do for denorm field
			

        //stage 3
                                                    //check if exponent are equal
            if (Small_exp_mantissa_80  < Large_mantissa_80) begin
                //Small_exp_mantissa_80 = ((~ Small_exp_mantissa_80 ) + 1'b1);
		//$display("what small_exp:%b",Small_exp_mantissa_80);
		S_mantissa_80 = Small_exp_mantissa_80;
		L_mantissa_80 = Large_mantissa_80;
            end
            else begin
                //Large_mantissa_80 = ((~ Large_mantissa_80 ) + 1'b1);
		//$display("what large_exp:%b",Large_mantissa_80);
			
		S_mantissa_80 = Large_mantissa_80;
		L_mantissa_80 = Small_exp_mantissa_80;
             end       
        //stage 4
        //add the two mantissa's
	
	if (e1_80!=0 & e2_80!=0) begin
		if (s1_80 == s2_80) begin
        		Add_mant_80 = S_mantissa_80 + L_mantissa_80;
		end else begin
			Add_mant_80 = L_mantissa_80 - S_mantissa_80;
		end
	end	
	else begin
		Add_mant_80 = L_mantissa_80;
	end
         
	//renormalization for mantissa and exponent
	

	//stage 5
	// if e1==e2, no shift for exp
        Final_expo_80 =  Larger_exp_80 + renorm_exp_80;
	
	Add1_mant_80 = Add_mant_80 << renorm_shift_80;

	Final_mant_80 = Add1_mant_80[9:1];  	

        
	if (s1_80 == s2_80) begin
		Final_sign_80 = s1_80;
	end 

	if (e1_80 > e2_80) begin
		Final_sign_80 = s1_80;	
	end else if (e2_80 > e1_80) begin
		Final_sign_80 = s2_80;
	end
	else begin

		if (m1_80 > m2_80) begin
			Final_sign_80 = s1_80;		
		end else begin
			Final_sign_80 = s2_80;
		end
	end	
	
	c_80 = (a==0 & b==0)?0:{Final_sign_80,Final_expo_80,Final_mant_80};
    end
    
    always @(posedge clk)begin 
    if (Add_mant_80[9] ) begin
		renorm_shift_80 = 4'd1;
		renorm_exp_80 = 4'd1;
	end
	else if (Add_mant_80[8])begin
		renorm_shift_80 = 4'd2;
		renorm_exp_80 = 0;		
	end
	else if (Add_mant_80[7])begin
		renorm_shift_80 = 4'd3; 
		renorm_exp_80 = -1;
	end 
	else if (Add_mant_80[6])begin
		renorm_shift_80 = 4'd4; 
		renorm_exp_80 = -2;		
	end  
	else if (Add_mant_80[5])begin
		renorm_shift_80 = 4'd5; 
		renorm_exp_80 = -3;		
	end      
	end 
    
    
//    always @(posedge clk) begin
//            if(reset) begin
//                Num_shift_80 <= #1 0;
//            end
//    end
    
endmodule
