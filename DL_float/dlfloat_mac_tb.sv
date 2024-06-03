module dlfloat_mac_tb();

  logic [15:0] a, b;
  logic rst_n, clk;
  logic [15:0] c;

  
  dlfloat_mac dut (
    .a(a),
    .b(b),
    .c(c),
    .rst_n(rst_n),
    .clk(clk)
  );

 
  initial 
  begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  
  initial  begin
     #10 rst_n = 1;
    
    #10 
     // Test Case 1:same sign positve
    a = 16'b1011111010100011; // a=1.32
    b = 16'b0100000001110011; // b=2.45 
    #10
    // Test Case 2:same sign negative
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b1100000001110011; // b=-2.45 
    #10;
    // Test Case 3:different sign 
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b0100000001110011; // b=2.45 
    #10;
    // Test Case 4:one operand is zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0100000001110011; // b=2.45 
    #10;
     // Test Case 6:both operands are zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0000000000000000; // b=0 
    #10;
     // Test Case 6:subnormals
     a = 16'b0000000110101100; // a=subnormal
     b = 16'b0100000001110011; // b=2.45 
    #10;
     // Test Case 7:Nan and inf
    a = 16'b1111111111111111; // a=inf/nan
    b = 16'b0011111010100011; // b=1.32 
    #10;
    // Test Case 8:underflow and normal
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0011111010100011; // b=1.32 
    #10;
    // Test Case 9:overrflow and normal
    a = 16'b0111110111111110; // a=largest +ve number
    b = 16'b0011111010100011; // b=1.32 
    #10;
    // Test Case 10:overerflow and underflow
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0111110111111110; // b=largest +ve number 
    #10;

    
    $finish;
  end
initial begin
        $monitor("Time: %0t | a: %b | b: %b | c: %b", $time, a, b, c);
    end
endmodule
