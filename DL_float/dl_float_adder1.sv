module dlfloat_adder(input clk,input rst_n, input [15:0]a, input [15:0]b, output reg[15:0]c);
    
    reg    [15:0] Num_shift_80; 
    reg    [5:0]  Larger_exp_80,Final_expo_80;
    reg    [9:0] Small_exp_mantissa_80,S_mantissa_80,L_mantissa_80,Large_mantissa_80;
    reg    [8:0] Final_mant_80;
    reg    [10:0] Add_mant_80,Add1_mant_80;
    reg    [5:0]  e1_80,e2_80;
    reg    [8:0] m1_80,m2_80;
    reg          s1_80,s2_80,Final_sign_80;
    reg    [8:0]  renorm_shift_80;
    integer signed   renorm_exp_80;
  	
   
    
  always @(posedge clk) begin
    if(!rst_n) begin
      c = 16'b0;
    end 
    else begin
        //stage 1
	     e1_80 = a[14:9];
	     e2_80 = b[14:9];
          m1_80 = a[8:0];
	      m2_80 = b[8:0];
          s1_80 = a[15];
	      s2_80 = b[15];
        
          if (e1_80  > e2_80) begin
             Num_shift_80           = e1_80 - e2_80;
             Larger_exp_80          = e1_80;                     
             Small_exp_mantissa_80  = {1'b1,m2_80};
             Large_mantissa_80      = {1'b1,m1_80};
          end
        
          else begin
            Num_shift_80           = e2_80 - e1_80;
            Larger_exp_80          = e2_80;
            Small_exp_mantissa_80  = {1'b1,m1_80};
            Large_mantissa_80      = {1'b1,m2_80};
          end
 
	      if (e1_80 == 0 | e2_80 ==0) begin
	        Num_shift_80 = 0;
	      end
	      else begin
	        Num_shift_80 = Num_shift_80;
	      end
      
        
        //stage 2
        // append 1 and shift
	    if (e1_80 != 0) begin
	      Small_exp_mantissa_80  = (Small_exp_mantissa_80 >> Num_shift_80);
        end
	    else begin
	      Small_exp_mantissa_80 = Small_exp_mantissa_80;
	    end

	    if (e2_80!= 0) begin
            Large_mantissa_80 = Large_mantissa_80;
	    end
	    else begin
	       Large_mantissa_80 = Large_mantissa_80;
	    end	
              
       //stage 3
       //add the mantissas
                                                    
        if (Small_exp_mantissa_80  < Large_mantissa_80) begin
		   S_mantissa_80 = Small_exp_mantissa_80;
		   L_mantissa_80 = Large_mantissa_80;
        end
        else begin
			
		   S_mantissa_80 = Large_mantissa_80;
		   L_mantissa_80 = Small_exp_mantissa_80;
        end       
                       
        Add_mant_80=11'b0;
	
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
     //stage 4
        if (Add_mant_80[10] ) begin
		   Add1_mant_80= Add_mant_80 >> 1;
		   renorm_exp_80 = 4'd1;
	    end
        else begin 
           if (Add_mant_80[9])begin
		     renorm_shift_80 = 0;
		     renorm_exp_80 = 0;		
	       end
           else if (Add_mant_80[8])begin
		     renorm_shift_80 = 8'd1; 
		     renorm_exp_80 = -1;
	        end 
           else if (Add_mant_80[7])begin
		      renorm_shift_80 = 8'd2; 
		      renorm_exp_80 = -2;		
	       end  
           else if (Add_mant_80[6])begin
		      renorm_shift_80 = 8'd3; 
		      renorm_exp_80 = -3;		
	       end
           else if (Add_mant_80[5])begin
		      renorm_shift_80 = 8'd4; 
		      renorm_exp_80 = -4;		
	       end
           else if (Add_mant_80[4])begin
		      renorm_shift_80 = 8'd5; 
		      renorm_exp_80 = -5;		
	       end
           else if (Add_mant_80[3])begin
		      renorm_shift_80 = 8'd6; 
		      renorm_exp_80 = -6;		
	       end
           else if (Add_mant_80[2])begin
		      renorm_shift_80 = 8'd7; 
		      renorm_exp_80 = -7;		
	        end
           else if (Add_mant_80[1])begin
		      renorm_shift_80 = 8'd8; 
		      renorm_exp_80 = -8;		
	        end
           else if (Add_mant_80[0])begin
		      renorm_shift_80 = 8'd9; 
		      renorm_exp_80 = -9;		
	        end
           Add1_mant_80 = Add_mant_80 << renorm_shift_80;
        
        end
     
      
        Final_expo_80 =  Larger_exp_80 + renorm_exp_80;
	
        Final_mant_80 = Add1_mant_80[8:0]; 

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
      if( a==16'hFFFF | b==16'hFFFF) begin
        c = 16'hFFFF;
      end
      else begin
	     c = (a==0 & b==0)?0:{Final_sign_80,Final_expo_80,Final_mant_80};
      end 
    end 
    end
endmodule
