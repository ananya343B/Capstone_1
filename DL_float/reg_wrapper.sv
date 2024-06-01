`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2024 18:23:57
// Design Name: 
// Module Name: reg_wrapper
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

module reg_wrapper(
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] reg_a,
    output reg [15:0] reg_b,
    output reg write_en
);

reg [1:0] state;
reg [15:0] temp_data;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state <= 2'b00; // Initialize state machine
        reg_a <= 16'b0; // Initialize registers
        reg_b <= 16'b0;
        write_en <= 0;
    end
    else begin
        case (state)
            2'b00: begin
                temp_data <= data_in;
//                reg_a <= data_in;
                state <= 2'b01;
            end
            2'b01: begin
                reg_a <= temp_data;
                reg_b <= data_in;
                write_en <= 1;
                state <= 2'b00;
            end
            default: state <= 2'b00; // Reset state to default
        endcase
    end
end



endmodule

