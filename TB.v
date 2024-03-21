module detector010_tb();

reg clk,rst,xin;
wire y;
wire [9:0] count;

detector010 tb(clk,xin,rst,y,count);

initial begin
    clk = 0;
    forever begin
        #1 clk = ~clk;
    end
end

initial begin
    rst = 1;
    xin = 1;
    #10;
    rst = 0;
    repeat(1000) begin
        xin = 0;
        @(negedge clk);
        xin = 1;
        @(negedge clk);
        xin = 0;
        @(negedge clk);
    end
    $stop;
end

initial begin
    $monitor ("rstn= %b , xin= %b , y= %b , count= %b ",rst,xin,y,count);
end

endmodule