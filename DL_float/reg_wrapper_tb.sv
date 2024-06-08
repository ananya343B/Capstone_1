`timescale 1ns / 1ps

module tb_reg_wrapper;


reg clk;
reg rst;
reg [15:0] data_in;
wire [15:0] reg_a;
wire [15:0] reg_b;
wire write_en;

reg_wrapper uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .reg_a(reg_a),
    .reg_b(reg_b),
    .write_en(write_en)
);

// Clock generation
always #5 clk = ~clk; 

initial begin
    clk = 0;
    rst = 0;
    data_in = 0;

    // Apply reset at beginning
    rst = 1;
    #10;
    rst = 0;
    #10;
    rst = 1;

    // Test case 1: reg_a and reg_b hold different values
    data_in = 16'h1234;
    #10; 
    data_in = 16'h5678;
    #10; 
    if (reg_a == 16'h1234 && reg_b == 16'h5678 && write_en == 1) begin
        $display("Test Case 1 Passed");
    end else begin
        $display("Test Case 1 Failed");
        $display("Expected reg_a = 16'h1234, reg_b = 16'h5678, write_en = 1");
        $display("Got reg_a = %h, reg_b = %h, write_en = %b", reg_a, reg_b, write_en);
    end

    // Test case 2: 
    data_in = 16'hABCD;
    #10; 
    data_in = 16'hEF01;
    #10; 
    if (reg_a == 16'hABCD && reg_b == 16'hEF01 && write_en == 1) begin
        $display("Test Case 2 Passed");
    end else begin
        $display("Test Case 2 Failed");
        $display("Expected reg_a = 16'hABCD, reg_b = 16'hEF01, write_en = 1");
        $display("Got reg_a = %h, reg_b = %h, write_en = %b", reg_a, reg_b, write_en);
    end

    // Test case 3: Check after reset
    rst = 0; //reset
    #10;
    rst = 1;
    data_in = 16'h1111;
    #10; 
    data_in = 16'h2222;
    #10;
    if (reg_a == 16'h1111 && reg_b == 16'h2222 && write_en == 1) begin
        $display("Test Case 3 Passed");
    end else begin
        $display("Test Case 3 Failed");
        $display("Expected reg_a = 16'h1111, reg_b = 16'h2222, write_en = 1");
        $display("Got reg_a = %h, reg_b = %h, write_en = %b", reg_a, reg_b, write_en);
    end

    // Test case 4: Check for same value in both registers (2 clks)
    data_in = 16'h3333;
    if (reg_a == 16'h1111 && reg_b == 16'h2222 && write_en == 1) begin
        $display("Test Case 4 Phase 1 Passed");
    end else begin
        $display("Test Case 4 Phase 1 Failed");
        $display("Expected reg_a = 16'h1111, reg_b = 16'h2222, write_en = 1");
        $display("Got reg_a = %h, reg_b = %h, write_en = %b", reg_a, reg_b, write_en);
    end

    #20;
    if (reg_a == 16'h3333 && reg_b == 16'h3333 && write_en == 1) begin
        $display("Test Case 4 Phase 2 Passed");
    end else begin
        $display("Test Case 4 Phase 2 Failed");
        $display("Expected reg_a = 16'h3333, reg_b = 16'h3333, write_en = 1");
        $display("Got reg_a = %h, reg_b = %h, write_en = %b", reg_a, reg_b, write_en);
    end

   
    $stop;
end

endmodule
