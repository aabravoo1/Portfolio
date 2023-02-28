module binary_counter (in_sel, in_p, ou_z, in_clk, rst);
	parameter n = 4;
	input in_clk, rst;
	input [1:0] in_sel;
	input [n-1 : 0] in_p;
	output reg[n-1 : 0] ou_z;
	wire clk1;
	
	clk_prog cl(in_clk, clk1);
  initial
    ou_z = 0;
	
  always @(posedge clk1, negedge rst)
		begin
        if(~rst)
			begin
			 ou_z = 0;
			end
		else if (in_sel == 2'b11 )
			ou_z = ou_z + 1; 
		else if (in_sel == 2'b10 )
			ou_z = ou_z - 1;
		else 
			ou_z = in_p;
		end
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