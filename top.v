module top(clk, rst, in1, in2, out1, out2);
input clk, rst, in1, in2;
output reg out1, out2;
reg [1:0] cs, ns;
reg r1;
wire a;

//memory state
always @(posedge clk)//NOTE : maybe we should write here posedge rst
if (rst)
	cs <= 0;
else 
	cs <= ns; 

//next state logic
always @ (*) begin
	case (cs)
		0 	: ns <= 1;
		1  	: ns <= 1; //NOTE : FSM Deadlock
		2  	: ns <= in1; //NOTE : unreachable state
		default	: ns <= 0;
	endcase
end


assign a = ~in1 ;

//
always @ (posedge clk) begin //NOTE : maybe we should write here posedge rst
if (rst)
  out2 <= 1'b0;
else
  case ( {a,in1} )
    2'b00: out2 <= 1'b0; //NOTE : unreachable state
    2'b01: out2 <= in2/in1;  //wont be reported by super linter 
    2'b11: out2 <= in1 ? in2/in1 : 1'b0;  //wont be reported by super linter //NOTE : unreachable state 
		default: out2 <= 1'b1;
  endcase
end

always @ (*)//Error : multiple always block for the same event
	if (rst)
	     out1 <= 1'b0;
	else
		if (in1)
			out1 <= in1;//Error : latch out1 


always @(posedge clk)
  r1 <= 1'b0; //Error : latch for r1


always @(posedge clk) 
	if (rst)
		out1 <= 1'b0 ;
	else
		if (in1)
			out1<= in2;
		else
			out1<= 1'bx;

endmodule
