
module dir_decider(
    input rst,
    input clk_12500Hz,
    input up_but,
    input right_but,
    input down_but,
    input left_but,
    output reg[1:0] dir
);
parameter UP=2'h0;
parameter RIGHT=2'h1;
parameter DOWN=2'h2;
parameter LEFT=2'h3;
reg [1:0] cs, ns;
always @(posedge clk_12500Hz or posedge rst) begin
    if (rst) begin
        cs <= UP;
    end else begin
        cs <= ns;
    end
end
always @(*) begin
    case(cs)
        UP: ns = rst ? UP : (right_but ? RIGHT : (left_but ? LEFT : UP));
        RIGHT: ns = rst ? UP : (up_but ? UP : (down_but ? DOWN : RIGHT));
        DOWN: ns = rst ? UP : (left_but ? LEFT : (right_but ? RIGHT : DOWN));
        LEFT: ns = rst ? UP : (up_but ? UP : (down_but ? DOWN : LEFT));
    endcase
end
always @(*) begin
    case(cs)
        UP: dir = 2'd0;
        RIGHT: dir = 2'd1;
        DOWN: dir = 2'd2;
        LEFT: dir = 2'd3;
    endcase
end
endmodule
