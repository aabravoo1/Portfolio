//Mariana Gonzalez Bravo A01630948, Nicol Gomez, Andres Bravo
package mips_pkg;

parameter DATA_WIDTH = 16;
parameter N_WORDS = 32;
parameter INSTRUCTION_WIDTH = 32; //length of instructions
parameter DATA_WIDTH_IN = 5;
parameter DATA_WIDTH_OUT = 16;
parameter WORDS_INSTRUCTION = 256;//no. of words in instruction memory

typedef enum logic [3:0] {
		ALU_ADD  = 4'b0000,
		ALU_SUB  = 4'b0001,
		ALU_NAND = 4'b0010,
		ALU_NOR  = 4'b0011,
		ALU_XNOR = 4'b0100,
		ALU_AND  = 4'b0101,
		ALU_OR   = 4'b0110,
		ALU_XOR  = 4'b0111,
		ALU_SLL  = 4'b1000,
		ALU_SRL  = 4'b1001,
		ALU_SLA  = 4'b1010,
		ALU_SRA  = 4'b1011,
		ALU_LUI  = 4'b1100,
		ALU_LLI  = 4'b1101,
		ALU_CMP  = 4'b1110,
		ALU_LI   = 4'b1111
		} alu_op_t;

typedef enum logic [5:0] {
	ADD_FUNC  = 6'b100000,
	SUB_FUNC  = 6'b100001,
	NAND_FUNC = 6'b010000,
	NOR_FUNC  = 6'b010001,
	XNOR_FUNC = 6'b010010,
	AND_FUNC  = 6'b010011,
	OR_FUNC   = 6'b010100,
	XOR_FUNC  = 6'b010101,
	SLL_FUNC  = 6'b001000,
	SRL_FUNC  = 6'b001010,
	SLA_FUNC  = 6'b001011,
	SRA_FUNC  = 6'b001100,
	JR_FUNC   = 6'b110010
    } func_t;

typedef enum logic [5:0] {
	Rtype       = 6'b000000,
	Itype_ADDI  = 6'b000010,
	Itype_SUBI  = 6'b000011,
	Itype_NANDI = 6'b010000,
	Itype_NORI  = 6'b010001,
	Itype_XNORI = 6'b010010,
	Itype_ANDI  = 6'b010011,
	Itype_ORI   = 6'b010100,
	Itype_XORI  = 6'b010101,
	Itype_LUI   = 6'b001000,
	Itype_LLI   = 6'b001001,
	Itype_LI    = 6'b001010,
	Itype_LW    = 6'b000100,
	Itype_SW    = 6'b000101,
	Itype_BEQ   = 6'b100000,
	Itype_BNEQ  = 6'b100001,
	Itype_BZ    = 6'b100010,
	Itype_BNEG  = 6'b100011,
	Jtype_J     = 6'b110000,//*******
	Jtype_JAL   = 6'b110001 //*******
	} op_t;


endpackage
