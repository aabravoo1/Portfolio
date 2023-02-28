
module lifo #(parameter DATA_WIDTH  = 6,
			  parameter STACK_DEPTH = 16)
			 (input logic                    clk,
			  input logic                    asyn_n_rst,
			  input logic                    push,
			  input logic                    pop,
			  input logic [DATA_WIDTH-1 : 0] data_in,
			  output logic[DATA_WIDTH-1 : 0] data_out,
			  output logic                   full,
			  output logic                   empty 
			 );
			 
logic [DATA_WIDTH-1:0] stack [STACK_DEPTH];
logic signed [$clog2(STACK_DEPTH):0] stack_pointer; 

assign empty = (stack_pointer == -1) ? 1'b1: 1'b0;
assign full  = (stack_pointer == STACK_DEPTH -1) ? 1'b1: 1'b0;

always_ff @(posedge clk, negedge asyn_n_rst) begin
	if(!asyn_n_rst) begin                            //rst
		stack_pointer = -1;
		for (int i = 0; i < STACK_DEPTH; i++)begin
				stack[i]      <= 0;
		end
	end
///////////////////////////////////////////////////////////	
	else if(push)begin                               //push
		if(!full) begin 
			stack_pointer        += 1; 
			stack[stack_pointer] <= data_in;
		end
	end
/////////////////////////////////////////////////////////	
	else if (pop) begin                             //pop
		if(!empty) begin
			data_out             = stack[stack_pointer];
			stack[stack_pointer] = 0;
			stack_pointer -= 1;
		end
	end
end

endmodule 

//stack pinter in stack, if yes what if data = 2, stack depth = 64, o logic [$clog2(STACK_DEPTH)-1 :0] stack_pointer 
//eliminate after pop?
//store 0?