module gray_counter(in_sel, in_clk, in_p, ou_g, rst);
	parameter n = 6;
	input in_clk, rst;
	input [1:0] in_sel;
	input [n-1:0] in_p;
	output[n-1:0] ou_g;
	reg [n-1:0] ou_z;
	wire clk1;
	
	clk_prog clk(in_clk, clk1);
	binary_to_gray btg(ou_z, ou_g); 
	
	always @(posedge clk1, negedge rst)
		begin
			if (~rst)
				ou_z = 0;
			else if (in_sel == 2'b11 )
				ou_z = ou_z + 1; 
			else if (in_sel == 2'b10 )
				ou_z = ou_z - 1;
			else 
				ou_z = in_p;
		end
endmodule
	
module binary_to_gray (in_b, ou_g);
	parameter n = 6;
	input [n-1:0] in_b;
	output reg[n-1:0] ou_g;
	reg [n:0] i; 
	
	always @(*)
		begin
		for (i = 0; i < n-1; i = i + 1)
			ou_g[i] <= in_b[i+1] ^ in_b[i];
		ou_g[n-1] = in_b[n-1];
		end
endmodule

module clk_prog(in_clk, clk1);//1 HERZ
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
        if(counter1 == 24999999)
          clk1 = 1'b1; 
        else if(counter1 == 49999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule 
/*
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
*/  
	