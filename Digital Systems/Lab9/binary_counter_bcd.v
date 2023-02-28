module binary_counter_bcd(in_sel, in_p, ou_ha, ou_hb, ou_hc, ou_hd, in_clk, rst);
	parameter n = 14;
	input in_clk, rst;
	input [1:0] in_sel;
	input [n-1:0] in_p;
	output[6:0] ou_ha, ou_hb, ou_hc, ou_hd;
	reg [n-1:0] ou_z;
	wire clk1;
	
	clk_prog clk(in_clk, clk1);
	binary_to_bcd bcd(ou_z, ou_ha, ou_hb, ou_hc, ou_hd); 
	
	always @(posedge in_clk, negedge rst)
		begin
			if (~rst)
				ou_z = 0; 
			else if (in_sel == 2'b11 )
				begin
				ou_z = ou_z + 1; 
				if(ou_z == 14'b10011100010000)
					ou_z = 0;
				end
			else if (in_sel == 2'b10 )
				begin
				if(ou_z == 0)
					ou_z = 14'b10011100001111;
				else 
					ou_z = ou_z - 1;
				end
			else if (in_p > 14'b10011100001111)
				ou_z = 0;
			else 
				ou_z = in_p;
		end
endmodule

module binary_to_bcd(in_bin,ou_fa,ou_fb,ou_fc,ou_fd);
	input [13:0] in_bin;
	output [6:0] ou_fa,ou_fb,ou_fc,ou_fd;
	
	reg [3:0] mil,cent,dec,un;
	
	integer n;
	
	always @(in_bin)
		begin
			mil = 4'b0000;
			cent = 4'b0000;
			dec = 4'b0000;
			un = 4'b0000;
			
          for (n=13;n>=0;n=n-1)
				begin
				  if (mil>=5)
						mil= mil +3;
                  if (cent>=5)
						cent= cent+3;
                  if (dec>=5)
						dec=dec + 3;
                  if (un>=5)
						un=un +3;
					
					mil=mil<<1;
					mil[0]=cent[3];
					cent=cent<<1;
					cent[0]=dec[3];
					dec=dec<<1;
					dec[0]=un[3];
					un=un<<1;
					un[0]=in_bin[n];			
				end	
		end
	bcd7_4bh m(mil, ou_fa[0],ou_fa[1],ou_fa[2],ou_fa[3],ou_fa[4],ou_fa[5],ou_fa[6]);
	bcd7_4bh c(cent,ou_fb[0],ou_fb[1],ou_fb[2],ou_fb[3],ou_fb[4],ou_fb[5],ou_fb[6]);
	bcd7_4bh d(dec, ou_fc[0],ou_fc[1],ou_fc[2],ou_fc[3],ou_fc[4],ou_fc[5],ou_fc[6]);
	bcd7_4bh u(un,  ou_fd[0],ou_fd[1],ou_fd[2],ou_fd[3],ou_fd[4],ou_fd[5],ou_fd[6]);
endmodule

module bcd7_4bh(in_a,ou_fa,ou_fb,ou_fc,ou_fd,ou_fe,ou_ff,ou_fg);
	input [3:0] in_a;
	output ou_fa,ou_fb,ou_fc,ou_fd,ou_fe,ou_ff,ou_fg;
  
	wire [3:0] in_a;
	wire ou_fa,ou_fb,ou_fc,ou_fd,ou_fe,ou_ff,ou_fg;
  
	assign 	ou_fa=(in_a==4'h0)?1'b0:(in_a==4'h1)?1'b1:(in_a==4'h2)?1'b0:(in_a==4'h3)?1'b0:(in_a==4'h4)?1'b1:(in_a==4'h5)?1'b0:(in_a==4'h6)?1'b0:(in_a==4'h7)?1'b0:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b0:(in_a==4'hA)?1'b0:(in_a==4'hB)?1'b1:(in_a==4'hC)?1'b0:(in_a==4'hD)?1'b1:(in_a==4'hE)?1'b0:(in_a==4'hF)?1'b0:1'bx,
			ou_fb=(in_a==4'h0)?1'b0:(in_a==4'h1)?1'b0:(in_a==4'h2)?1'b0:(in_a==4'h3)?1'b0:(in_a==4'h4)?1'b0:(in_a==4'h5)?1'b1:(in_a==4'h6)?1'b1:(in_a==4'h7)?1'b0:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b0:(in_a==4'hA)?1'b0:(in_a==4'hB)?1'b1:(in_a==4'hC)?1'b1:(in_a==4'hD)?1'b0:(in_a==4'hE)?1'b1:(in_a==4'hF)?1'b1:1'bx,
			ou_fc=(in_a==4'h0)?1'b0:(in_a==4'h1)?1'b0:(in_a==4'h2)?1'b1:(in_a==4'h3)?1'b0:(in_a==4'h4)?1'b0:(in_a==4'h5)?1'b0:(in_a==4'h6)?1'b0:(in_a==4'h7)?1'b0:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b0:(in_a==4'hA)?1'b0:(in_a==4'hB)?1'b0:(in_a==4'hC)?1'b1:(in_a==4'hD)?1'b0:(in_a==4'hE)?1'b1:(in_a==4'hF)?1'b1:1'bx,
			ou_fd=(in_a==4'h0)?1'b0:(in_a==4'h1)?1'b1:(in_a==4'h2)?1'b0:(in_a==4'h3)?1'b0:(in_a==4'h4)?1'b1:(in_a==4'h5)?1'b0:(in_a==4'h6)?1'b0:(in_a==4'h7)?1'b1:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b0:(in_a==4'hA)?1'b1:(in_a==4'hB)?1'b0:(in_a==4'hC)?1'b0:(in_a==4'hD)?1'b0:(in_a==4'hE)?1'b0:(in_a==4'hF)?1'b1:1'bx,
			ou_fe=(in_a==4'h0)?1'b0:(in_a==4'h1)?1'b1:(in_a==4'h2)?1'b0:(in_a==4'h3)?1'b1:(in_a==4'h4)?1'b1:(in_a==4'h5)?1'b1:(in_a==4'h6)?1'b0:(in_a==4'h7)?1'b1:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b1:(in_a==4'hA)?1'b0:(in_a==4'hB)?1'b0:(in_a==4'hC)?1'b0:(in_a==4'hD)?1'b0:(in_a==4'hE)?1'b0:(in_a==4'hF)?1'b0:1'bx,
			ou_ff=(in_a==4'h0)?1'b0:(in_a==4'h1)?1'b1:(in_a==4'h2)?1'b1:(in_a==4'h3)?1'b1:(in_a==4'h4)?1'b0:(in_a==4'h5)?1'b0:(in_a==4'h6)?1'b0:(in_a==4'h7)?1'b1:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b0:(in_a==4'hA)?1'b0:(in_a==4'hB)?1'b0:(in_a==4'hC)?1'b0:(in_a==4'hD)?1'b1:(in_a==4'hE)?1'b0:(in_a==4'hF)?1'b0:1'bx,
			ou_fg=(in_a==4'h0)?1'b1:(in_a==4'h1)?1'b1:(in_a==4'h2)?1'b0:(in_a==4'h3)?1'b0:(in_a==4'h4)?1'b0:(in_a==4'h5)?1'b0:(in_a==4'h6)?1'b0:(in_a==4'h7)?1'b1:(in_a==4'h8)?1'b0:(in_a==4'h9)?1'b0:(in_a==4'hA)?1'b0:(in_a==4'hB)?1'b0:(in_a==4'hC)?1'b1:(in_a==4'hD)?1'b0:(in_a==4'hE)?1'b0:(in_a==4'hF)?1'b0:1'bx;
	
endmodule

module clk_prog(in_clk, clk1); //CLK 5 HERZ
	input in_clk;
	output reg clk1; 
	reg [26:0] counter1;
	
	initial 
		begin
		clk1 = 1'b0;
		
		counter1 = 0;
		
		end
	
	always @(posedge in_clk)
		begin 
		counter1 = counter1 + 1'b1;
        if(counter1 == 4999999)
          clk1 = 1'b1; 
        else if(counter1 == 9999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule 
	