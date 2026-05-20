`define THIS_CNT cnt[i[2:0]][j[2:0]]
module body_map(
    input rst,
    input clk,
    input eat,
    input [5:0] len,
    input [5:0] next_head,
    output reg [63:0] snake_body_map
);
reg [5:0] snake [0:63];

integer i;
reg dead;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        dead <= 0;
    end else begin
        if (snake[next_head]>1) begin
            dead <= 1'd1;
        end else begin
            dead <= 1'd0;
        end
    end
    
end

always @(posedge clk or posedge rst) begin
    if(rst)begin
        for(i=0;i<64;i=i+1)begin
            snake[i]<=0;
        end
    end else begin
        if (dead == 1) begin
            for(i=0;i<64;i=i+1)begin
                if (snake[i]>0 && i!=next_head) begin
                   snake[i]<=snake[i];
                end
            end
        end else begin
       
            if(eat==1)begin
                for(i=0;i<64;i=i+1)begin
                    if(i==next_head)begin
                        snake[i]<=len+1;
                    end else if (snake[i]!=0) begin
                       snake[i]<=snake[i];
                    end
                end
             end
             else if(eat==0)begin
                snake[next_head]<=len;
                for(i=0;i<64;i=i+1)begin
                    if (snake[i]>0 && i!=next_head) begin
                       snake[i]<=snake[i]-1;
                    end
                end
             end
         end
     end
end
    always @(*) begin
        for(i=0;i<64;i=i+1)begin
            if (snake[i]!=0) begin
                snake_body_map[i]=1;
            end else begin
                snake_body_map[i]=0;
            end
        end
    end
endmodule


