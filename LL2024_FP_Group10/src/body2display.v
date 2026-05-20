`define ROW 8+
`define COL 0+
module body2display(
    input clk,
    input rst,
    input [5:0] food_loc,
    input [63:0] snake_body_map,
    output [15:0] display
);
    
    reg [2:0] row;
    reg [5:0] cnt;
    wire [15:0] col_row_display_format;
//poor-dong-see, lan dong see, le - se - dong - see
    always@(posedge clk or posedge rst)begin
        if(rst) begin
            row <= 0;
            cnt <= 0;
        end
        else begin
            row <= row + 1;
            cnt <= (cnt == 6'h6)? 0 : cnt + 1;
        end
    end

    assign col_row_display_format = {(8'b1 << row), ~(snake_body_map[8*row+:8])} & {8'hff,~({7'h0,((food_loc[5:3] == row) && (cnt == 0))} << food_loc[2:0])};  //{y, x}
    // assign col_row_display_format[15:8] = (8'b1 << row);
    // assign col_row_display_format[15:8] = ~(snake_body_map[8*row+:8]) & ~({7'h0,((food_loc[5:3] == row) && (cnt == 0))} << food_loc[2:0]);
    // ~(snake_body_map[8*row+:8]) ====> show snake_body
    // ~({7'h0,((food_loc[5:3] == row) && (cnt == 0))} << food_loc[2:0]) ====> show food
    // the food will light up when food_loc_y == row and cnt == 0
    // the period of row and cnt should be coprime
    /*                                                       The col that needs to shine should be set to 0                                                 */
    assign display = ~{
        col_row_display_format[`COL 1 - 1], //PIN 16
        col_row_display_format[`COL 2 - 1], //PIN 15
        col_row_display_format[`ROW 7 - 1], //PIN 14
        col_row_display_format[`COL 8 - 1], //PIN 13
        col_row_display_format[`ROW 5 - 1], //PIN 12
        col_row_display_format[`COL 3 - 1], //PIN 11
        col_row_display_format[`COL 5 - 1], //PIN 10
        col_row_display_format[`ROW 8 - 1], //PIN 9
        col_row_display_format[`ROW 4 - 1], //PIN 8
        col_row_display_format[`ROW 2 - 1], //PIN 7
        col_row_display_format[`COL 7 - 1], //PIN 6
        col_row_display_format[`COL 6 - 1], //PIN 5
        col_row_display_format[`ROW 1 - 1], //PIN 4
        col_row_display_format[`COL 4 - 1], //PIN 3
        col_row_display_format[`ROW 3 - 1], //PIN 2
        col_row_display_format[`ROW 6 - 1]  //PIN 1
    };//connect to LED PIN 
    //the '~' is because "Cathode Row, Anode Column" 


endmodule
