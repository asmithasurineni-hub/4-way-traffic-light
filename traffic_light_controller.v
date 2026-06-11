`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 19:33:20
// Design Name: 
// Module Name: traffic_light_controller
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


module traffic_light_controller(

    input clk,
    input reset,

    output reg [1:0] north,
    output reg [1:0] east,
    output reg [1:0] south,
    output reg [1:0] west

);

// State Definitions
parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100,
          S5 = 3'b101,
          S6 = 3'b110,
          S7 = 3'b111;

// Simulation Timings
parameter GREEN_MAIN  = 16;
parameter GREEN_OTHER = 8;
parameter YELLOW_TIME = 4;

reg [2:0] current_state, next_state;
reg [27:0] counter;

//================================================
// State Register + Counter
//================================================
always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        current_state <= S0;
        counter <= 0;
    end
    else
    begin
        if(counter == (
            (current_state==S0 || current_state==S4) ? GREEN_MAIN-1 :
            (current_state==S2 || current_state==S6) ? GREEN_OTHER-1 :
            YELLOW_TIME-1))
        begin
            current_state <= next_state;
            counter <= 0;
        end
        else
            counter <= counter + 1;
    end
end

//================================================
// Next State Logic
//================================================
always @(*)
begin
    case(current_state)

        S0: next_state = S1;
        S1: next_state = S2;
        S2: next_state = S3;
        S3: next_state = S4;
        S4: next_state = S5;
        S5: next_state = S6;
        S6: next_state = S7;
        S7: next_state = S0;

        default: next_state = S0;

    endcase
end

//================================================
// Output Logic (Paper State Table)
//================================================
always @(*)
begin

    case(current_state)

        S0:
        begin
            north = 1; east = 3; south = 3; west = 3;
        end

        S1:
        begin
            north = 2; east = 2; south = 3; west = 3;
        end

        S2:
        begin
            north = 3; east = 1; south = 3; west = 3;
        end

        S3:
        begin
            north = 3; east = 2; south = 2; west = 3;
        end

        S4:
        begin
            north = 3; east = 3; south = 1; west = 3;
        end

        S5:
        begin
            north = 3; east = 3; south = 2; west = 2;
        end

        S6:
        begin
            north = 3; east = 3; south = 3; west = 1;
        end

        S7:
        begin
            north = 2; east = 3; south = 3; west = 2;
        end

        default:
        begin
            north = 3; east = 3; south = 3; west = 3;
        end

    endcase
end

endmodule