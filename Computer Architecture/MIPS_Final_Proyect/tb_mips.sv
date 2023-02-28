import mips_pkg::*;
module tb_mips;

localparam BIN_CODE_FILE="mips_tests.txt";
logic  clk;
logic  asyn_n_rst;

mips #(.FILE_NAME(BIN_CODE_FILE)) dut_mips(.*);

always begin
	clk = 0;
	#1ns;
	clk = 1;
	#1ns;
end

initial begin
	 asyn_n_rst = 1;
	 #2ns;
	 asyn_n_rst = 0;
	 #2ns;
	 asyn_n_rst = 1; //$readmemb(BIN_CODE_FILE, tb_mips.dut_mips.im1.inst_mem);
	 #2ns;

end

endmodule
