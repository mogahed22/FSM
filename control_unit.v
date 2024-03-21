module control_unit(speed_limit,car_speed,leading_distance,clk,rst,unlock_doors,accelerate_car);

parameter STOP = 2'b00 ;
parameter ACCELERATE = 2'b01;
parameter DECELERATE = 2'b11;
parameter MIN_DISTANCE = 7'b0101000;

input [7:0] speed_limit , car_speed;
input [6:0] leading_distance;
input clk ,rst;

output reg unlock_doors , accelerate_car;

reg cs,ns;

//output logic
always @(cs) begin
    case(cs)
    STOP :begin
    unlock_doors = 1;
    accelerate_car = 1;
    end

    ACCELERATE: begin
    unlock_doors = 0;
    accelerate_car = 1;
    end

    DECELERATE: begin
    unlock_doors=0;
    accelerate_car=0;
    end
    endcase
end

//state memory
always @(posedge clk or posedge rst) begin
    if(rst) begin
        cs <= STOP;
        //unlock_doors <= 0;
        //accelerate_car <= 0;
    end
    else begin
        cs <= ns;
    end
end

//next state logic
always @(cs,speed_limit,car_speed,leading_distance)begin
    case(cs)
    STOP:
    if (leading_distance >= MIN_DISTANCE) ns <= ACCELERATE;
    else if (leading_distance < MIN_DISTANCE) ns <= STOP;

    ACCELERATE:
    if(leading_distance >= MIN_DISTANCE && car_speed < speed_limit) ns <= ACCELERATE;
    else if (leading_distance < MIN_DISTANCE || car_speed > speed_limit) ns <= DECELERATE;

    DECELERATE:
    if(leading_distance >= MIN_DISTANCE && car_speed < speed_limit) ns <= ACCELERATE;
    else if (leading_distance < MIN_DISTANCE || car_speed > speed_limit) ns <= DECELERATE;
    else if (car_speed==0) ns <= STOP;
    endcase
end
endmodule