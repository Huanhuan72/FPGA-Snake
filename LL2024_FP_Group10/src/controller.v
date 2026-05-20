`define UP    2'h0
`define RIGHT 2'h1
`define DOWN  2'h2
`define LEFT  2'h3
`define HEAD_Y head[5:3]
`define HEAD_X head[2:0]
module controller(
    input rst,
    input clk,
    input [1:0] dir,
    input [5:0] food_loc, 
    input [63:0] snake_body_map,
    output reg [5:0] next_head,
    output reg [5:0] len,
    output reg eat,
    output reg food_update
);
    parameter IDLE=2'd0, EAT=2'd1, UPDATE=2'd2;
    parameter INITIAL_HEAD = 6'd0;
    parameter INITIAL_LEN = 6'd1;
    reg [5:0] head;
    always @(*) begin
        case (dir)
            2'b00: next_head = {`HEAD_Y-3'd1, `HEAD_X}; // Move up
            2'b01: next_head = {`HEAD_Y, `HEAD_X+3'd1}; // Move right 
            2'b10: next_head = {`HEAD_Y+3'd1, `HEAD_X}; // Move down 
            2'b11: next_head = {`HEAD_Y, `HEAD_X-3'd1}; // Move left
        endcase
    end
    always @(*) begin
        if (snake_body_map[food_loc]==1'd1) begin
            food_update = 1'd1;
        end else begin
            food_update = 1'd0;
        end
    end
    always @(*) begin
        if (rst) begin
            eat <= 0;
        end else if (snake_body_map[food_loc]==1'd1 && next_head != food_loc) begin
            eat <= 0;
        end else if (next_head == food_loc) begin
            eat <= 1'd1;
        end else begin
            eat <= 0;
        end
    end     
    // Synchronous reset and update logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the snake's length and head location
            len <= INITIAL_LEN;
            {`HEAD_Y, `HEAD_X} <= INITIAL_HEAD;
           
        end else begin
            // Update the head location
            {`HEAD_Y, `HEAD_X} <= next_head;
            
            // Check if the snake eats the food
            if (snake_body_map[food_loc]==1'd1 && next_head != food_loc) begin
               
            end else if (next_head == food_loc) begin
                len <= len + 6'd1; // Increase length
                 // Request new food location
            end else begin
                
            end
        end
    end
endmodule
