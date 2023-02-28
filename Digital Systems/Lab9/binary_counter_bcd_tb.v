module binary_counter_tb;
	parameter n = 14;
	reg in_clk;
	reg rst;
	reg [1:0] sel;
	reg [n-1:0] in_p;
	wire[6:0] ou_ha, ou_hb, ou_hc, ou_hd;
  	
	binary_counter_bcd jc(
		.in_sel(sel), 
		.in_p(in_p), 
		.ou_ha(ou_ha), 
		.ou_hb(ou_hb), 
		.ou_hc(ou_hc), 
		.ou_hd(ou_hd), 
		.in_clk(in_clk), 
		.rst(rst)
		);
		
	initial
		begin 
		$dumpfile("v.vcd");
		$dumpvars(1);
          $monitor("rst = %b, sel = %b, p = %b, A = %b, B = %b, C = %b, D = %b", rst, sel, in_p, ou_ha, ou_hb, ou_hc, ou_hd);
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
        in_p = 14'b10011100001111;
		rst = 0;
		#30 rst = 1;
        #200 sel = 10;
        #200 sel = 00;
        #30  sel = 10;
          
        in_p = 14'b01111001100001;
        #100 sel = 00;
        #30  sel = 11; 
        #100$stop;
		end
endmodule