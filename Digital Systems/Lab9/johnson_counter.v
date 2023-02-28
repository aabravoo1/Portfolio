module johnson_counter (in_sel, in_clk, in_p, ou_j, rst);
	parameter n = 5;
	input in_clk, rst;
	input [1:0] in_sel;
	input [n-1:0] in_p;
	output[n-1:0] ou_j;
	reg [n-1:0] bin;
	wire clk1;
	
	clk_prog c(in_clk, clk1);
	binary_to_johnson bj(bin, ou_j);
	
	initial
		begin
		bin = 0;
		end
	
  always @(posedge clk1, negedge rst)
		begin
			if(~rst)
			bin = 0; 
			else if (in_sel == 2'b11 )
				begin
				bin = bin + 1; 
				if (bin == 2*n)
					bin = 0;
				end
			else if (in_sel == 2'b10 )
				begin
				bin = bin - 1;
				if (bin == 0)
					bin = 2*n;
				end
			else 
				bin = in_p;
		end
endmodule

module binary_to_johnson (in_bin, ou_j);
	parameter n = 5;
	input[n-2:0] in_bin;
	output[n-1:0] ou_j;
    reg [n-1:0] Reg;
	
	initial 
		begin 
          Reg = 'hfffffffffffffffffffff;
        end
  assign ou_j = (in_bin > n)? Reg << (in_bin - n)
               :(in_bin < n)? Reg >> (n - in_bin)
    		   : Reg;
endmodule
	
module clk_prog(in_clk, clk1);
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
		else 
			if (counter < n+1)
				begin
				ou_j = ou_j << 1;
				ou_j[n-1] = 1'b1;
				end
			else if (counter >= n+1)
				begin 
				ou_j = ou_j << 1;
				ou_j[n-1] = 1'b0;
				end
			else if (counter == n+n+1)
				counter = 0;
*/