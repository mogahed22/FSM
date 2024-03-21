module gray_counter(clk,rst,gray_out);
input clk , rst;
output  [1:0]gray_out;
reg [1:0] counter_out;
always @(posedge clk or posedge rst) begin
    if (rst) counter_out <= 0;
    else counter_out <= counter_out+1;
end
assign gray_out[1] = counter_out [1];
assign gray_out[0] = ^counter_out;
endmodule