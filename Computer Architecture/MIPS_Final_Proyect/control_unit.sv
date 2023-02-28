import mips_pkg::*;
module control_unit(
					input  op_t       op,
					input  func_t     func,
					input  logic      eq,
					input  logic      zero,
					input  logic      neg,
					output logic      rf_we,
					output logic      alu_a_sel,
					output alu_op_t   alu_op,
					output logic      dm_we,
					output logic      data_in_sel,
					output logic      Qt_imm_sel,
					output logic      pc_sel,
					output logic      rd_sel,
					output logic      jump_address_sel,
					output logic      jump_data_sel,
					output logic      jr_sel
					);


always_comb begin
	case(op)
		Rtype: begin
			alu_a_sel   = 1'b0; //Qs in a of alu
			rf_we       = 1'b1; //rf_we on
			rd_sel      = 1'b0; //rd = rd
			pc_sel      = 1'b0; //pc = pc
			dm_we       = 1'b0; //dm_we off
			data_in_sel = 1'b1; //result of alu in data_in
			Qt_imm_sel  = 1'b1; //Qt in b of alu
			jump_address_sel = 1'b1; //normal address
			jump_data_sel    = 1'b0; //normal data
			jr_sel           = 1'b0; //normal pc

			case(func)
				ADD_FUNC : alu_op = ALU_ADD;
				SUB_FUNC : alu_op = ALU_SUB;
				NAND_FUNC: alu_op = ALU_NAND;
				NOR_FUNC : alu_op = ALU_NOR;
				XNOR_FUNC: alu_op = ALU_XNOR;
				AND_FUNC : alu_op = ALU_AND;
				OR_FUNC  : alu_op = ALU_OR;
				XOR_FUNC : alu_op = ALU_XOR;
				SLL_FUNC : begin
						   alu_op = ALU_SLL; alu_a_sel = 1;//sa in a of alu
						   end
				SRL_FUNC : begin
						   alu_op = ALU_SRL; alu_a_sel = 1;//sa in a of alu
						   end
				SLA_FUNC : begin
						   alu_op = ALU_SLA; alu_a_sel = 1;//sa in a of alu
						   end
				SRA_FUNC : begin
						   alu_op = ALU_SRA; alu_a_sel = 1;//sa in a of alu
						   end
				JR_FUNC  : begin
				           jr_sel           = 1'b1; // pc = Qs
						   alu_op           = ALU_ADD;
						   rf_we            = 1'b0;
						   end
				default  : alu_op = ALU_ADD;
				endcase
			end
	//I-type, arithmetic/logic instructions:
		Itype_ADDI : begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_ADD;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
		Itype_SUBI : begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_SUB;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
		Itype_NANDI: begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_NAND;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
		Itype_NORI : begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_NOR;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
		Itype_XNORI: begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_XNOR;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
		Itype_ANDI : begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_AND;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
		Itype_ORI  : begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_OR;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
				     end
		Itype_XORI : begin
					 alu_a_sel   = 1'b0;
			         rf_we       = 1'b1;
			         rd_sel      = 1'b1;// rd = rt
			         pc_sel      = 1'b0;
			         dm_we       = 1'b0;
			         data_in_sel = 1'b1;
			         Qt_imm_sel  = 1'b0;//immediate in b of alu
					 alu_op      = ALU_XOR;
					 jump_address_sel = 1'b1; //normal address
					 jump_data_sel    = 1'b0; //normal data
					 jr_sel           = 1'b0; //normal pc
					 end
	//I-type load instructions:
		Itype_LUI: begin
				   alu_a_sel   = 1'b0;
			       rf_we       = 1'b1;
			       rd_sel      = 1'b1;// rd = rt
			       pc_sel      = 1'b0;
			       dm_we       = 1'b0;
			       data_in_sel = 1'b1;//result in data_in
			       Qt_imm_sel  = 1'b0;//immediate in b of alu
				   alu_op      = ALU_LUI;
				   jump_address_sel = 1'b1; //normal address
				   jump_data_sel    = 1'b0; //normal data
				   jr_sel           = 1'b0; //normal pc
				   end
		Itype_LLI: begin
				   alu_a_sel   = 1'b0;
			       rf_we       = 1'b1;
			       rd_sel      = 1'b1;// rd = rt
			       pc_sel      = 1'b0;
			       dm_we       = 1'b0;
			       data_in_sel = 1'b1;// result in data_in
			       Qt_imm_sel  = 1'b0;//immediate in b of alu
				   alu_op      = ALU_LLI;
				   jump_address_sel = 1'b1; //normal address
				   jump_data_sel    = 1'b0; //normal data
				   jr_sel           = 1'b0; //normal pc
				   end
		Itype_LI : begin
				   alu_a_sel   = 1'b0;
			       rf_we       = 1'b1;
			       rd_sel      = 1'b1;// rd = rt
			       pc_sel      = 1'b0;
			       dm_we       = 1'b0;
			       data_in_sel = 1'b1;// result in data_in
			       Qt_imm_sel  = 1'b0;//immediate in b of alu
				   alu_op      = ALU_LI;
				   jump_address_sel = 1'b1; //normal address
				   jump_data_sel    = 1'b0; //normal data
				   jr_sel           = 1'b0; //normal pc
				   end
		Itype_LW : begin
				   alu_a_sel   = 1'b0;
			       rf_we       = 1'b1;
			       rd_sel      = 1'b1;// rd = rt
			       pc_sel      = 1'b0;
			       dm_we       = 1'b0;
			       data_in_sel = 1'b0;// DM in data_in
			       Qt_imm_sel  = 1'b0;//immediate in b of alu
				   alu_op      = ALU_ADD;
				   jump_address_sel = 1'b1; //normal address
				   jump_data_sel    = 1'b0; //normal data
				   jr_sel           = 1'b0; //normal pc
				   end
	//I-type store instruction:
		Itype_SW: begin
				  alu_a_sel   = 1'b0;
			      rf_we       = 1'b0;//rf_we off
			      rd_sel      = 1'b1;// rd = rt
			      pc_sel      = 1'b0;
			      dm_we       = 1'b1;//dm_we on
			      data_in_sel = 1'b0;// DM in data_in*
			      Qt_imm_sel  = 1'b0;//immediate in b of alu
				  alu_op      = ALU_ADD;
				  jump_address_sel = 1'b1; //normal address
				  jump_data_sel    = 1'b0; //normal data
				  jr_sel           = 1'b0; //normal pc
				  end
	//I-type branch instructions:
		Itype_BEQ : begin
					alu_a_sel   = 1'b0;
					rf_we       = 1'b0;//rf_we off
					rd_sel      = 1'b1;// rd = rt*
					dm_we       = 1'b0;//dm_we off
					data_in_sel = 1'b1;//result in data_in*
					Qt_imm_sel  = 1'b1;//Qt in b of alu
					alu_op      = ALU_CMP;
					jump_address_sel = 1'b1; //normal address
					jump_data_sel    = 1'b0; //normal data
					jr_sel           = 1'b0; //normal pc
					case(eq)
						1'b1: pc_sel  = 1'b1;
						1'b0: pc_sel  = 1'b0;
						default: pc_sel = 1'b0;
					endcase
					end
		Itype_BNEQ: begin
					alu_a_sel   = 1'b0;
					rf_we       = 1'b0;//rf_we off
					rd_sel      = 1'b1;// rd = rt*
					dm_we       = 1'b0;//dm_we off
					data_in_sel = 1'b1;//result in data_in*
					Qt_imm_sel  = 1'b1;//Qt in b of alu
					alu_op      = ALU_CMP;
					jump_address_sel = 1'b1; //normal address
					jump_data_sel    = 1'b0; //normal data
					jr_sel           = 1'b0; //normal pc
					case(eq)
						1'b1: pc_sel  = 1'b0;
						1'b0: pc_sel  = 1'b1;
						default: pc_sel = 1'b0;
					endcase
					end
		Itype_BZ  : begin
					alu_a_sel   = 1'b0;
					rf_we       = 1'b0;//rf_we off
					rd_sel      = 1'b1;// rd = rt*
					dm_we       = 1'b0;//dm_we off
					data_in_sel = 1'b1;//result in data_in*
					Qt_imm_sel  = 1'b1;//Qt in b of alu
					alu_op      = ALU_CMP;
					jump_address_sel = 1'b1; //normal address
					jump_data_sel    = 1'b0; //normal data
					jr_sel           = 1'b0; //normal pc
					case(zero)
						1'b1: pc_sel  = 1'b1;
						1'b0: pc_sel  = 1'b0;
						default: pc_sel = 1'b0;
					endcase
					end
		Itype_BNEG: begin
					alu_a_sel   = 1'b0;
					rf_we       = 1'b0;//rf_we off
					rd_sel      = 1'b1;// rd = rt*
					dm_we       = 1'b0;//dm_we off
					data_in_sel = 1'b1;//result in data_in*
					Qt_imm_sel  = 1'b1;//Qt in b of alu
					alu_op      = ALU_CMP;
					jump_address_sel = 1'b1; //normal address
					jump_data_sel    = 1'b0; //normal data
					jr_sel           = 1'b0; //normal pc
					case(neg)
						1'b1: pc_sel  = 1'b1;
						1'b0: pc_sel  = 1'b0;
						default: pc_sel = 1'b0;
					endcase
					end
		//J type Instructions
		Jtype_J  : begin
				   alu_a_sel   = 1'b0;
			       rf_we       = 1'b0;//rf_we off
			       rd_sel      = 1'b0;// rd
			       pc_sel      = 1'b1;//-------------pc = imm
			       dm_we       = 1'b0;//dm_we off
			       data_in_sel = 1'b1;//ALU in data_in
			       Qt_imm_sel  = 1'b1;//Qt in b of alu
				   alu_op      = ALU_CMP;
				   jump_address_sel = 1'b1; //normal address
				   jump_data_sel    = 1'b0; //normal data
				   jr_sel           = 1'b0; //normal pc
				   end
		Jtype_JAL: begin
		           alu_a_sel   = 1'b0;
			       rf_we       = 1'b1;//rf_we on
			       rd_sel      = 1'b0;// rd
			       pc_sel      = 1'b1;//-------------pc = imm
			       dm_we       = 1'b0;//dm_we off
			       data_in_sel = 1'b1;//ALU in data_in
			       Qt_imm_sel  = 1'b1;//Qt in b of alu
				   alu_op      = ALU_CMP;
				   jump_address_sel = 1'b0; //31 in address
				   jump_data_sel    = 1'b1; //PC + 1 in data
				   jr_sel           = 1'b0; //normal pc
				   end
		default: begin
				 alu_a_sel   = 1'b0;
			     rf_we       = 1'b1;
			     rd_sel      = 1'b0;// rd
			     pc_sel      = 1'b0;
			     dm_we       = 1'b0;
			     data_in_sel = 1'b1;
			     Qt_imm_sel  = 1'b1;//Qt in b of alu
				 alu_op      = ALU_CMP;
				 jump_address_sel = 1'b1; //normal address
				 jump_data_sel    = 1'b0; //normal data
				 jr_sel           = 1'b0; //normal pc
				 end
		endcase
	end

endmodule
