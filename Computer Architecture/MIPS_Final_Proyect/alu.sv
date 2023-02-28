//Andrés Antonio Bravo Orozco A01630783
import mips_pkg::*;
module alu (input logic signed [DATA_WIDTH -1 : 0] a,
			input logic signed [DATA_WIDTH -1 : 0] b,
			input alu_op_t op,
			output logic signed [DATA_WIDTH -1 : 0] result,
			output logic zero,
			output logic neg,
			output logic eq
			);

parameter half = DATA_WIDTH/2 ;

always_comb begin : alu
	case(op)
		ALU_ADD  : result = a + b;
		ALU_SUB  : result = a - b;
		ALU_NAND : result = ~(a & b);
		ALU_NOR  : result = ~(a | b);
		ALU_XNOR : result = ~(a ^ b);
		ALU_AND  : result = a & b;
		ALU_OR   : result = a | b;
		ALU_XOR  : result = a ^ b;
		ALU_SLL  : result = b << $unsigned(a);
		ALU_SRL  : result = b >> $unsigned(a);
		ALU_SLA  : result = b <<< $unsigned(a);
		ALU_SRA  : result = b >>> $unsigned(a);
		ALU_LUI  : result = {b[half -1 : 0], {half{1'b0}}};
		ALU_LLI  : result = {{half{1'b0}}, b[half -1: 0]};
		ALU_LI   : result = b;
		ALU_CMP  : result = 0;
		default  : result = 0;
	endcase
	end : alu

always_comb begin: flags
	if ( a == 0)
		zero = 1;
	else
		zero = 0;

	if ( a < 0)
		neg = 1;
	else
		neg = 0;

	if ( a > b ) begin
		eq = 0;
		end
	else if( a == b)begin
		eq = 1;
		end
	else begin
		eq = 0;
		end
	end : flags

endmodule
