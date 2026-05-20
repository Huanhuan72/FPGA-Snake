module random_generator(
    input clk,
    input set_seed, // rst of random gen
    output reg [2:0] idx,
    output reg [2:0] idy
);
reg [9:0] shift_reg;
always @(posedge clk or posedge set_seed) begin
    if (set_seed) begin
        shift_reg <= 10'b00001;
    end else begin
        shift_reg <= {shift_reg[8:0], shift_reg[9]^shift_reg[6]};
    end
end
always @(*) begin
    idx = shift_reg[2:0];
    idy = shift_reg[5:3];
end
endmodule