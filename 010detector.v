module detector010 (clk,xin,rst,y,count);

parameter idle = 2'b00 ;
parameter zero = 2'b01;
parameter one = 2'b10;
parameter store = 2'b11;

input clk,rst,xin;
output reg y;
output reg [9:0] count;

reg [1:0]cs,ns;

//memory state
always @(posedge clk or posedge rst) begin
    if (rst) begin
        //y<= 0;
        cs <= idle;
        count <= 0;
    end
    else cs <= ns;
end

//next state logic 
always @(cs,xin)begin
    case (cs)
        idle: begin
        if (xin) ns = cs;
        else ns = zero;
        end

        zero: begin
        if(!xin) ns = cs;
        else ns = one;
        end

        one: begin
        if(xin) ns = idle;
        else ns = store;
        end

        store: begin
        if(xin) ns = idle ;
        else ns = zero;
        end
    endcase
end

//output logic
always @(cs)begin
    case(cs)
        idle: y = 0;  
        zero: y=0;   
        one : y=0; 
        store:begin
        y=1;  count <= count +1 ;
        end
    endcase
end


endmodule