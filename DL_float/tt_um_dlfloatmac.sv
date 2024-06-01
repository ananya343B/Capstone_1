`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2024 18:22:59
// Design Name: 
// Module Name: tt_um_dlfloatmac
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


module tt_um_dlfloatmac (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire [15:0]data_in;
wire [15:0] c;
wire [15:0]wa,wb;
wire write_en;


assign uio_oe = write_en?8'b11111111:8'b00000000;


assign data_in = {uio_in,ui_in};


reg_wrapper wrap(clk,rst_n,data_in,wa,wb,write_en);
dlfloat_mac MAC(clk,rst_n,wa,wb,c);


assign uio_out = c[15:8];
assign uo_out = c[7:0];
  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  
endmodule

