module gray_counter_2bit (
    input clk,       
    input reset,     
    output reg [1:0] y 
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0]cs,ns;

// Internal signals
reg [1:0] binary_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        binary_count <= 2'b00; // Reset the counter to 0
    end else begin
            case (binary_count)
            A: y <= A;
            B: y <= B;
            C: y <= D;
            D: y <= C;
            default: y <= 2'b00; 
        endcase
        // Binary count increment
        if (binary_count == 2'b11) begin
            binary_count <= 2'b00; 
        end else begin
            binary_count <= binary_count + 1; 
        end
    end
end

//state memory
always @(posedge clk or posedge reset)begin
    if(reset) cs <= A;
    else cs <= ns;
end

//next state logic
always @(cs,y) begin
    case(cs)
    A: if(y==B) ns <= B;
    B: if(y==C) ns <= C;
    C: if(y==D) ns <= D;
    D: ns <= A;
    endcase
end

//output logic
/*always(cs)begin
    case(cs)
    
    endcase
end*/
endmodule
