`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 19:56:25
// Design Name: 
// Module Name: traffic_light_tb
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


module traffic_light_tb;

reg clk;
reg reset;

wire [1:0] north;
wire [1:0] east;
wire [1:0] south;
wire [1:0] west;

traffic_light_controller DUT(
    .clk(clk),
    .reset(reset),

    .north(north),
    .east(east),
    .south(south),
    .west(west));
always #50 clk = ~clk;
initial
begin
    clk = 0;
    reset = 1;
    #100;
    reset = 0;
    #5000;
    $stop;
end
endmodule