module matriz_tb;
	reg in_clk, rst; 
	wire[7:0] ou_c;
	wire[7:0] ou_f;
	
	matriz m(
		.in_clk(in_clk), 
		.rst(rst), 
		.ou_c(ou_c), 
		.ou_f(ou_f)
		);
	
	initial 
		begin
		$dumpfile("v,vcd");
		$dumpvars(1);
		$monitor("clk = %b, rst = %b, ou_c = %b, ou_f = %b", in_clk, rst, ou_c, ou_f);
		end
		
	initial
		begin 
		in_clk = 0;
		rst = 1; 
		forever 
			#10 in_clk = ~ in_clk;
		end
	
endmodule