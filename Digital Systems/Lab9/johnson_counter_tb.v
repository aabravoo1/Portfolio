module johnson_counter_tb;
	parameter n = 10;
	reg in_clk, rst;
	reg [1:0] sel;
	reg [n-1:0] in_p;
	wire[n-1:0] ou_j;
  
	johnson_counter jc(
		.in_sel(sel), 
		.in_clk(in_clk), 
		.in_p(in_p), 
        .ou_j(ou_j),
		.rst(rst)
      
		);
		
	initial
		begin 
		$dumpfile("v.vcd");
		$dumpvars(1);
          $monitor("clk = %b, rst =%b, sel = %b, p = %b, ou_j = %b", in_clk, rst, sel, in_p, ou_j);
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
        in_p = 6'd7;
		#30 rst = 1;
        #200 sel = 10;
        #200 sel = 00;
        #30  sel = 11; 
        #100 $stop;
		end
endmodule