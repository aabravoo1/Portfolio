module onehot_counter (in_sel, in_clk, in_p, ou_o, rst);
	parameter n = 5;
	input in_clk, rst;
	input [1:0] in_sel;
	input [n-1:0] in_p;
	output[n-1:0] ou_o;
	reg [n-1:0] bin;
	reg [n-1:0] num;
	wire clk1;
	
	clk_prog c(in_clk, clk1);
	binary_to_onehot bj(bin, ou_o);
	initial
		begin
          bin = 0;
          num = 32'hffffffffffffffff;
		end
	
  always @(posedge clk1, negedge rst)
		begin
		  if (~rst)
			bin = 0;
          else if (in_sel == 2'b11 )
            	begin
				bin = bin + 1;
                  if (bin == n)
					bin = 0;
                end
          else if (in_sel == 2'b10 )
            	begin
				bin = bin - 1;
                  if (bin == num )
					bin = n-1;
                end
			else 
				bin = in_p;
		end
endmodule

module binary_to_onehot(bin, ou_o);
	parameter n = 5;
	input [n-1:0] bin;
	output reg[n-1:0] ou_o;
	//reg [n-1:0] Reg;
		
	always @(*)
		begin
        ou_o = 0;
        ou_o[bin] = 1'b1;
		end
	//assign ou_o = Reg; 
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