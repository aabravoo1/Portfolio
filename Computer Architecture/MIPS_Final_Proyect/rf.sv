//Andres Bravo A01630783, Mariana Gonzalez A01630948, Nicol Gomez A00227180, Brenda Esquivel A01421610
import mips_pkg::*;

module rf # (
  parameter ADDRESS_WIDTH = $clog2(N_WORDS)
  )
  (
  input logic                        clk,
  input logic                        asyn_n_rst, //active low
  input logic                        we,
  input logic  [ADDRESS_WIDTH-1 : 0] rs1,
  input logic  [ADDRESS_WIDTH-1 : 0] rs2,
  input logic  [ADDRESS_WIDTH-1 : 0] rd ,
  input logic  [DATA_WIDTH-1 : 0]    data_in,
  output logic [DATA_WIDTH-1 : 0]    Qs1,
  output logic [DATA_WIDTH-1 : 0]    Qs2
  );

logic [DATA_WIDTH-1 : 0] registers [N_WORDS];


always_ff@(posedge clk, negedge asyn_n_rst) begin
  if(!asyn_n_rst) begin
		for(int i = 0; i < N_WORDS; i++) begin
			registers[i] <= 0;
		end
	end

  else if(we) begin
	if (rd == 0)
		registers[0] <= '0;
	else
    registers[rd] <= data_in;
  end
end

always_comb begin
  Qs1 = registers[rs1];
  Qs2 = registers[rs2];
end

endmodule
