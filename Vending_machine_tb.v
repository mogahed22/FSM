module vending_machine_tb();
    reg clk, reset, dollar, quarter;
    wire dispense, change;

    vending_machine vending_machine_inst (
        .clk(clk),
        .reset(reset),
        .dollar(dollar),
        .quarter(quarter),
        .dispense(dispense),
        .change(change)
    );

   
    always begin
        clk = 0;
        #5 clk = ~clk;
    end

   
    initial begin
        reset = 1;
        #10 reset = 0;
    end

    
    initial begin
        repeat (500) begin
       
        dollar = 1;
        quarter = 0;
        #20;
        dollar = 0;

        
        quarter = 1;
        #20;
        quarter = 0;

       
        reset = 1;
        #20;
        reset = 0;
        #20;
        reset = 1;
        #20;
        reset = 0;
        #20;
        end

        
        $stop;
    end

    // Display outputs
    always @(dispense, change) begin
        $display("dispense = %b, change = %b", dispense, change);
    end

endmodule