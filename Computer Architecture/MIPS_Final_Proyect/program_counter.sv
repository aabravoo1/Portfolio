module program_counter (
						 input logic [7:0] D,
						 input logic clk,
						 input logic asyn_n_rst,
						 output logic [7:0] pc
						);

	always_ff @(posedge clk or negedge asyn_n_rst)
		if (!asyn_n_rst)
			pc <= 8'b0000000;
		else
			pc <= D;

endmodule
