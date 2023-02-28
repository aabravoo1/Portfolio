module clk_prog_tb;
	reg in_clk;
	wire clk1, clk10, clk1k, clk10k;
	
	clk_prog dut(
		.in_clk(in_clk),
		.clk1(clk1), 
		.clk10(clk10), 
		.clk1k(clk1k), 
		.clk10k(clk10k)
		);
	
	initial
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		$monitor("in_clk = %b, clk1 = %b, clk10 = %b, clk1k = %b, clk10k = %b", in_clk, clk1, clk10, clk1k, clk10k);
		end

	initial
		begin
		in_clk = 0;
		forever
			#1 in_clk = ~in_clk;
		#100000000 $stop; 
		end 
endmodule 
	
	