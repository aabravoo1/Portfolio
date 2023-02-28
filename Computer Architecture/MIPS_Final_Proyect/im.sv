//Andres Bravo A01630783, Mariana Gonzalez A01630948, Nicol Gomez A00227180, Brenda Esquivel A01421610
import mips_pkg::*;
module im #(parameter FILE_NAME = "mips_bin.txt")
         (input  logic [$clog2(WORDS_INSTRUCTION)-1:0] address,
          output logic      [INSTRUCTION_WIDTH -1:0]   data_out
         );

logic [INSTRUCTION_WIDTH -1:0] inst_mem [WORDS_INSTRUCTION];

initial begin
	$readmemb(FILE_NAME, inst_mem);
end

always_comb begin
    data_out = inst_mem[address];
end

endmodule
