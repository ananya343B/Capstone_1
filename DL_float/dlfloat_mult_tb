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
    a = 16'b1011111010100011; // a=1.32
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
    c1 =16'b0100000100111010; // c1= -3.226
    #10;
    if (c == c1) 
      $display("Test case 2: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 2: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    // Test Case 3:different sign 
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0100000100111010; // c1= -3.226
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
    
     // Test Case 6:both operands are zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0000000000000000; // b=0 
   c1 =16'b0000000000000000; // c1=0
    #10;
    if (c == c1) 
      $display("Test case 6: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 6: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
     // Test Case 6:subnormals
     a = 16'b0000000110101100; // a=subnormal
     b = 16'b0100000001110011; // b=2.45 
    c1 = 16'b0000000000000000; // c1=0
    #10;
    if (c == c1) 
      $display("Test case 6: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 6: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
     // Test Case 7:Nan and inf
    a = 16'b1111111111111111; // a=inf/nan
    b = 16'b0011111010100011; // b=1.32 
   c1 = 16'b1111111111111111; // c1=Nan
    #10;
    if (c == c1) 
      $display("Test case 7: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 7: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    // Test Case 8:underflow and normal
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0011111010100011; // b=1.32 
   // c1 =16'b0000000000000000; // c1=Nan
    #10;
   // if (c == c1) 
    $display("Test case 8: a = %b, b = %b, c = %b", a, b, c);
    /* else 
       $display("Test case 8: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);*/
    // Test Case 9:overrflow and normal
    a = 16'b0111110111111110; // a=largest +ve number
    b = 16'b0011111010100011; // b=1.32 
   // c1 =16'b0000000000000000; // c1=Nan
    #10;
   // if (c == c1) 
    $display("Test case 9: a = %b, b = %b, c = %b", a, b, c);
    /* else 
       $display("Test case 8: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);*/
    // Test Case 10:overerflow and underflow
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0111110111111110; // b=largest +ve number 
   // c1 =16'b0000000000000000; // c1=Nan
    #10;
   // if (c == c1) 
    $display("Test case 9: a = %b, b = %b, c = %b", a, b, c);
    /* else 
       $display("Test case 8: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);*/
    
    $finish;
  end

endmodule
