module food(
    input clk_12500Hz, //higher freq
    input rst,
    input set_seed,
    input food_update,
    output reg [5:0] food_loc
);
wire [5:0] new_food_loc;
random_generator random_generator (
    .clk(clk_12500Hz),
    .set_seed(set_seed), // rst of random gen
    .idx(new_food_loc[2:0]),
    .idy(new_food_loc[5:3])
);
always @(posedge clk_12500Hz or posedge rst) begin
    if (rst) food_loc <= 6'b100100;
    else if (food_update) food_loc <= new_food_loc;
    else food_loc <= food_loc;
end
endmodule
