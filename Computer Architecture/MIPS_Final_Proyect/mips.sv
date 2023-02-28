//Andres Bravo A01630783, Mariana Gonzalez A01630948, Nicol Gomez A00227180, Brenda Esquivel A01421610
import mips_pkg::*;
module mips#(parameter FILE_NAME = "mips_bin.txt")
  (input  logic               clk,
   input  logic               asyn_n_rst
);

logic [N_WORDS-1:0] instruction;
logic [4:0]         rs, rt, rd, rd1, rd2;           //input  register file
logic [15:0]        Qs, Qt;                    //output RF
logic [4:0]         sa;                        //input  zero extend
logic [15:0]        sa_zero_ext;               //output zero extend
op_t                op;                        //input  control unit
func_t              func;                      //input  control unit
alu_op_t            alu_op;                    //output control unit
logic               alu_a_sel;                 //output control unit
logic [15:0]        alu_a, alu_b;              //output mux
logic [15:0]        alu_result;                //output alu
logic [15:0]        immediate, Q, D, ds;
logic               zero, eq, neg, rf_we, dm_we, data_in_sel, Qt_imm_sel, pc_sel, rd_sel, jump_address_sel,jump_data_sel, jr_sel;
logic [7:0]         d1, pc1, next_pc0, out_pc, next_pc;

assign op         = op_t'(instruction[31:26]);
assign rs         = instruction[25:21];
assign rt         = instruction[20:16];
assign rd1        = instruction[15:11];
assign sa         = instruction[10:6];
assign func       = func_t'(instruction[5:0]);
assign immediate  = instruction[15:0];
assign d1         = instruction[7:0];



control_unit
ct(
  .op(op),
  .func(func),
  .eq(eq),
  .zero(zero),
  .neg(neg),
  .rf_we(rf_we),
  .alu_a_sel(alu_a_sel),
  .alu_op(alu_op),
  .dm_we(dm_we),
  .data_in_sel(data_in_sel),
  .Qt_imm_sel(Qt_imm_sel),
  .pc_sel(pc_sel),
  .rd_sel(rd_sel),
  .jump_data_sel(jump_data_sel),
  .jump_address_sel(jump_address_sel),
  .jr_sel(jr_sel)
  );

rf
register_f(
      .clk(clk),
      .asyn_n_rst(asyn_n_rst),
      .we(rf_we),
      .rs1(rs),
      .rs2(rt),
      .rd(rd),
      .data_in(D),
      .Qs1(Qs),
      .Qs2(Qt)
  );

  mux_2x1  //data in RF rd2
  #(.DATA_WIDTH(5))
  mux_2rf2(
      .d0(rd1),
      .d1(rt),
      .sel(rd_sel),
      .out(rd2)
  );

  mux_2x1  //data in RF rd
  #(.DATA_WIDTH(5))
  mux_2rf(
      .d0(5'b11111),
      .d1(rd2),
      .sel(jump_address_sel),
      .out(rd)
  );

  mux_2x1 //Mux PC
  #(.DATA_WIDTH(8))
  mux_2PC(
      .d0(pc1),
      .d1(d1),
      .sel(pc_sel),
      .out(next_pc0)
  );

  mux_2x1 //Mux PC jr_sel
  #(.DATA_WIDTH(8))
  mux_2PC2(
      .d0(next_pc0),
      .d1(Qs[7:0]),
      .sel(jr_sel),
      .out(next_pc)
  );

  mux_2x1 //data in alu_a
  #(.DATA_WIDTH(16))
  mux_2a(
      .d0(Qs),
      .d1(sa_zero_ext),
      .sel(alu_a_sel),
      .out(alu_a)
  );

  mux_2x1 //data in alu b
  #(.DATA_WIDTH(16))
  mux_2b(
      .d0(immediate),
      .d1(Qt),
      .sel(Qt_imm_sel),
      .out(alu_b)
  );

  mux_2x1 //out DM Q & pc + 1
  #(.DATA_WIDTH(16))
  mux_2ds(
      .d0(Q),
      .d1(alu_result),
      .sel(data_in_sel),
      .out(ds)
  );

  mux_2x1 //data in rf D
  #(.DATA_WIDTH(16))
  mux_2data(
      .d0(ds),
      .d1({8'b00000000,pc1}),
      .sel(jump_data_sel),
      .out(D) //tenemos que cambiar esta D
  );

  zero_ext
  ze(
      .data_in(sa),
      .data_out(sa_zero_ext)
  );

  alu
  alu_r(
      .op(alu_op),
      .a(alu_a),
      .b(alu_b),
      .result(alu_result),
      .zero(zero),
      .neg(neg),
      .eq(eq)
  );

  dm
  dm_i(
      .clk(clk),
      .we(dm_we),
      .address(alu_result[7:0]),
      .data_in(Qt),
      .data_out(Q)
  );

adder
add12(
  .data_in(out_pc),
  .data_out(pc1)
  );

program_counter
pc12(
  .D(next_pc),
  .clk(clk),
  .asyn_n_rst(asyn_n_rst),
  .pc(out_pc)
  );

im
#(.FILE_NAME(FILE_NAME))
im1(
  .address(out_pc),
  .data_out(instruction)
);

endmodule
