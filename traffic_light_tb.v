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

// Instantiate DUT (Device Under Test)

traffic_light_controller DUT(

    .clk(clk),
    .reset(reset),

    .north(north),
    .east(east),
    .south(south),
    .west(west)

);

// Clock Generation
// 100 ns period = 10 MHz

always #50 clk = ~clk;

// Test Sequence

initial
begin

    clk = 0;
    reset = 1;

    #100;

    reset = 0;

    // Run long enough to observe several states

    #5000;

    $stop;

end

endmodule