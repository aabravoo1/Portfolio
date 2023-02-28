module tb_sum_squares;

localparam BIN_CODE_FILE="sum_squares.txt";
localparam N = 57;
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
	 tb_sum_squares.dut_mips.dm_i.ram_mem[0] = N;
	 asyn_n_rst = 1;
	 #2ns;
	 asyn_n_rst = 0;
	 #2ns;
	 asyn_n_rst = 1; 
	 #2ns;

end

endmodule
//llega hasta el 45, en 46 sobrepasa los 15 bits positivos 