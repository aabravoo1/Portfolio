module onehot_counter_tb;
  	parameter n = 6;
	reg in_clk, rst;
	reg [1:0] sel;
	reg [n-1:0] in_p;
	wire[n-1:0] ou_o;
  
	
	onehot_counter oc(
		.in_sel(sel), 
		.in_clk(in_clk), 
		.in_p(in_p), 
        .ou_o(ou_o),
		.rst(rst)
		);
		
	initial
		begin 
		$dumpfile("v.vcd");
		$dumpvars(1);
        $monitor("clk = %b, rst = %b, sel = %b, p = %b, ou_o = %b", in_clk, rst, sel, in_p, ou_o);
		end
		
	initial 
		begin
		in_clk = 1'b0;
		forever
			#10 in_clk = ~in_clk;
		end
  
  	initial 
		begin
        sel = 11;
		rst = 0;
        in_p = 6'd3;
		#30 rst = 1;
        #200 sel = 10;
        #200 sel = 00;
        #30  sel = 11; 
        #100 $stop;
		end
		
endmodule
		