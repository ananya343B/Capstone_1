module dlfloat_mult_tb();

  logic [15:0] a, b;
  logic  clk;
  logic [15:0] c;

  
  dlfloat_mult dut (
    .a(a),
    .b(b),
    .c(c),
    .clk(clk)
  );

 
  initial 
  begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  
  initial  begin
    logic [15:0] c1;
    
    
    #10 
      // Test Case 1:same sign positve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b0100000001110011; // b=2.45 
    c1= 16'b0100000100111010; // c1= 3.226
    #10;
    if (c == c1) 
      $display("Test case 1: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 1: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
     // Test Case 2:same sign negative
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b1100000001110011; // b=-2.45 
    c1 =16'b1100000100111010; // c1= -3.226
    #10;
    if (c == c1) 
      $display("Test case 2: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 2: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
     // Test Case 3:different sign 
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b1100000100111010; // c1= -3.226
    #10;
    if (c == c1) 
      $display("Test case 3: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 3: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
     // Test Case 4:one operand is zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0000000000000000; // c1=0
    #10;
    if (c == c1) 
      $display("Test case 4: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 4: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
     // Test Case 5:subnormals
     a = 16'b0000000110101100; // a=subnormal
     b = 16'b0100000001110011; // b=2.45 
    c1 = 16'b0000000000000000; // c1=0
    #10;
    if (c == c1) 
      $display("Test case 5: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 5: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
     // Test Case 6:Nan and inf
    a = 16'b1111111111111111; // a=inf/nan
    b = 16'b0011111010100011; // b=1.32 
   c1 = 16'b1111111111111111; // c1=Nan
    #10;
    if (c == c1) 
      $display("Test case 6: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 6: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
     // Test Case 7A:underflow and normal
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0011111010100011; // b=1.32 
    #10;
    $display("Test case 7A: a = %b, b = %b, c = %b", a, b, c);
    
     // Test Case 7B:underflow and underflow
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0000001000000000; // b=smallest +ve number
    #10;
    $display("Test case 7B: a = %b, b = %b, c = %b", a, b, c);
    
     // Test Case 7C:underflow and overflow
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0111110111111110; // b=largest +ve number 
    #10;
    $display("Test case :7C a = %b, b = %b, c = %b", a, b, c);
    
     // Test Case 7D:overflow and normal
    a = 16'b0111110111111110; // a=largest +ve number
    b = 16'b0011111010100011; // b=1.32 
    #10;
    $display("Test case 7D: a = %b, b = %b, c = %b", a, b, c);
    
     // Test Case 7E:overflow and overflow
    a = 16'b0111110111111110; // a=largest +ve number
    b = 16'b0111110111111110; // b=largest +ve number
    #10;
    $display("Test case 7E: a = %b, b = %b, c = %b", a, b, c);
   
    
    #240 $finish;
  end

endmodule
