module control_unit_tb();

reg [7:0] speed_limit , car_speed;
reg [6:0] leading_distance;
reg clk ,rst;

wire unlock_doors , accelerate_car;

control_unit tb(speed_limit,car_speed,leading_distance,clk,rst,unlock_doors,accelerate_car);

initial begin
    clk =0 ;
    forever begin
        #1 clk =~clk;
    end
end

/*initial begin
    rst = 1;
    #10;
    rst = 0;
    repeat (100) begin
        speed_limit = $random;
        car_speed = $random;
        leading_distance = $random;
        @(negedge clk);
    end
    $stop;
end*/

initial begin
        rst = 1;
        #10 rst = 0;
    end

    // Stimulus
    initial begin
        // Test case 1: Leading distance greater than or equal to MIN_DISTANCE
        speed_limit = 8'd60;
        car_speed = 8'd40;
        leading_distance = 7'd80;
        #50;

        // Test case 2: Leading distance less than MIN_DISTANCE, car speed less than speed limit
        car_speed = 8'd30;
        leading_distance = 7'd50;
        #50;

        // Test case 3: Leading distance less than MIN_DISTANCE, car speed greater than speed limit
        car_speed = 8'd70;
        #50;

        // Test case 4: Car speed equals 0
        car_speed = 8'd0;
        #50;

        // End simulation
        $stop;
    end


endmodule