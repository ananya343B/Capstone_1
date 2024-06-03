module reg_wrapper_tb();
  
  logic [15:0] data_in;
  logic rst, clk;
  logic [15:0] reg_a,reg_b;
  logic write_en;

   
  
    reg_wrapper dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .reg_a(reg_a),
        .reg_b(reg_b),
        .write_en(write_en)
    );

    
  initial 
   begin
    clk = 0;
    forever #5 clk = ~clk;
  end

    initial begin
        rst=0;
        data_in=16'b0;
        
        #5rst = 1;
      
         #5data_in=16'hA;
         #10
         data_in=16'hB;
         #10
         data_in=16'hC;
         #10
         data_in=16'hD;
        
      
        #60;
        $finish; 
    end

    
    initial begin
      $monitor("At time %t, clk = %b, rst = %b, data_in = %h, reg_a = %h,reg_b = %h, write_en = %b",$time, clk, rst, data_in, reg_a, reg_b,write_en);
    end

endmodule

