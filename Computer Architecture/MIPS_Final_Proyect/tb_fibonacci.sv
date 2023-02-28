module tb_fibonacci;

localparam BIN_CODE_FILE="fibonacci.txt";
localparam N = 24;
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
	 tb_fibonacci.dut_mips.dm_i.ram_mem[255] = N;
	 asyn_n_rst = 1;
	 #2ns;
	 asyn_n_rst = 0;
	 #2ns;
	 asyn_n_rst = 1; 
	 #2ns;

end

endmodule

//llega hasta el 24