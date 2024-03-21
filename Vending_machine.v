module vending_machine (
    input clk,           
    input reset,        
    input dollar,        
    input quarter,       
    output reg dispense, 
    output reg change    
);

// Define states

  parameter S0=0; 
   parameter S1=1; 
    parameter S2=2;
   parameter S3=3; 
   parameter S4=4;  

// Define state register
reg [2:0] state, next_state;

// Define state transition and output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0; 
        dispense <= 0; 
        change <= 0; 
    end
    else begin
        state <= next_state; 
    end
    end

always @(posedge clk) begin        
        case(state)
            S0: begin
                if (dollar)
                    next_state = S4; 
                else if (quarter)
                    next_state = S1; 
                else
                    next_state = S0; 
            end
            S1: begin
                if (dollar)
                    next_state = S4; 
                else if (quarter)
                    next_state = S2; 
                else
                    next_state = S1; 
            end
            S2: begin
                if (dollar)
                    next_state = S4; 
                else if (quarter)
                    next_state = S3; 
                else
                    next_state = S2; 
            end
            S3: begin
                if (dollar)
                    next_state = S4; 
                else if (quarter)
                    next_state = S3; 
                else
                    next_state = S3; 
            end
            S4: begin
                if (dollar) begin
                    next_state = S4; 
                    change <= 1; 
                end
                else if (quarter)
                    next_state = S3; 
                else
                    next_state = S4; 
            end
            default: next_state = S0; 
        endcase
    end

// Define Mealy output logic
always @(posedge clk) begin
    case(state)
        S0, S1, S2, S3: begin
            dispense <= 0; 
        end
        S4: begin
            dispense <= 1; 
        end
        default: dispense <= 0; 
    endcase
end

endmodule
