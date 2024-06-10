module dlfloat_adder_tb();
  
  logic [15:0]a,b;
  logic clk,rst_n;
  logic [15:0]c;
  
  dlfloat_adder dut(.a(a),
                   .b(b),
                   .clk(clk),
                   .rst_n(rst_n),
                   .c(c)
                  );
  initial begin
    clk=1;
    rst_n=0;
    forever #5clk=~clk;
  end
  
  initial begin
    logic [15:0]c1;
   
    #5 rst_n=1;
    
    #5// Test Case 1:same sign positve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0100000111000100; // c1= 3.765
    #10;
    if (c == c1) 
      $display("Test case 1: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 1: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    
    // Test Case 2:same sign negative
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b1100000001110011; // b=-2.45 
    c1 =16'b1100000111000100; // c1= -3.765
    #10;
    if (c == c1) 
      $display("Test case 2: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 2: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
     // Test Case 3:different sign -ve<+ve
    a = 16'b1011111010100011; // a=-1.32
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0011111001000100; // c1= 1.13
    #10;
    if (c == c1) 
      $display("Test case 3: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 3: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
    // Test Case 4:different sign -ve>+ve
    a = 16'b0011111010100011; // a=1.32
    b = 16'b1100000001110011; // b=-2.45 
   c1 =16'b1011111001000100; // c1= -1.13
    #10;
    if (c == c1) 
      $display("Test case 4: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 4: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
     // Test Case 5:one operand is zero
    a = 16'b0000000000000000; // a=0
    b = 16'b0100000001110011; // b=2.45 
    c1 =16'b0100000001110011; // c1=2.45
    #10;
    if (c == c1) 
      $display("Test case 5: PASS. a = %b, b = %b, c = %b, expected:%b", a, b, c,c1);
     else 
       $display("Test case 5: FAIL. a = %b, b = %b,  c = %b, expected: %b", a, b, c, c1);
     // Test Case 6:both are zero
     a = 16'b0000000000000000; // a=0
     b = 16'b0000000000000000; // b=0
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
     // Test Case 8A:underflow and normal
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0011111010100011; // b=1.32 
    #10;
    $display("Test case 8A: a = %b, b = %b, c = %b", a, b, c);
     // Test Case 8B:underflow and underflow
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0000001000000000; // b=smallest +ve number
    #10;
    $display("Test case 8B: a = %b, b = %b, c = %b", a, b, c);
     // Test Case 8C:underflow and overflow
    a = 16'b0000001000000000; // a=smallest +ve number
    b = 16'b0111110111111110; // b=largest +ve number 
    #10;
    $display("Test case 8C: a = %b, b = %b, c = %b", a, b, c);
     // Test Case 8D:overflow and normal
    a = 16'b0111110111111110; // a=largest +ve number
    b = 16'b0011111010100011; // b=1.32 
    #10;
    $display("Test case 8D: a = %b, b = %b, c = %b", a, b, c);
     // Test Case 8E:overflow and overflow
    a = 16'b0111110111111110; // a=largest +ve number
    b = 16'b0111110111111110; // b=largest +ve number
    #10;
    $display("Test case 8E: a = %b, b = %b, c = %b", a, b, c);
   
    
    
    #240 $finish;
  end
endmodule
