module matriz (in_clk, ou_c, ou_f);
	input in_clk; 
	output wire[15:0] ou_c;
	output wire[15:0] ou_f;
	reg [2:0] counter1;
	wire clk1k;
	
	initial
		begin
		counter1 = 0;
		end
	
	clk_prog1khz cp1k(in_clk, clk1k);
	binary_to_onehotN b0(counter1, ou_f[7:0]);
	binary_to_onehotP b1(counter1, ou_f[15:8]);
	registers r(in_clk, counter1, ou_c);
	
	always @(posedge clk1k, negedge rst)
		begin
			counter1 = counter1 + 1;
		end
endmodule 

module registers (clk, in_count, ou_c);
	input clk;
	input[2:0] in_count;
	output [15:0] ou_c;
	reg [7:0] words[69:0];
	integer i;
	wire clk1;
	wire[3:0] in_count2;
	
	initial 
		begin 
		words[0] =  0;
		words[1] =  8'b1000_0000;
		words[2] =  8'b1111_1111;
		words[3] =  8'b1000_0010;
		words[4] =  8'b1000_0100;
		words[5] =  0;
		words[6] =  8'b1000_0001;
		words[7] =  8'b0100_0010;
		words[8] =  8'b0010_0100;
		words[9] =  8'b0001_1000;
		words[10] = 8'b0001_1000;
		words[11] = 8'b0010_0100;
		words[12] = 8'b0100_0010;
		words[13] = 8'b1000_0001;
		words[14] = 0;
		words[15] = 8'b1001_1110;
		words[16] = 8'b1010_0001;
		words[17] = 8'b1100_0001;
		words[18] = 8'b1000_1110;
		words[19] = 0;
		words[20] = 0;
		words[21] = 0;
		words[22] = 0;
		words[23] = 8'b0111_0001;
		words[24] = 8'b1000_1001;
		words[25] = 8'b1000_1001;
		words[26] = 8'b1000_1110;
		words[27] = 0;
		words[28] = 8'b1111_1111;
		words[29] = 8'b0000_1001;
		words[30] = 8'b0000_1001;
		words[31] = 8'b1111_1111;
		words[32] = 0;
		words[33] = 8'b1111_1111;
		words[34] = 8'b0000_0010;
		words[35] = 8'b0000_0100;
		words[36] = 8'b0000_1000;
		words[37] = 8'b0000_0100;
		words[38] = 8'b0000_0010;
		words[39] = 8'b1111_1111;
		words[40] = 0;
		words[41] = 8'b1111_1111;
		words[42] = 8'b0000_1001;
		words[43] = 8'b0000_1001;
		words[44] = 8'b1111_1111;
		words[45] = 0;
		words[46] = 8'b1111_1111;
		words[47] = 8'b1000_0000;
		words[48] = 8'b1000_0000;
		words[49] = 8'b1111_1111;
		words[50] = 0;
		words[51] = 8'b1111_0001;
		words[52] = 8'b1001_0001;
		words[53] = 8'b1001_0001;
		words[54] = 8'b1111_1111;
		words[55] = 0;
		words[56] = 8'b1111_1111;
		words[57] = 8'b0000_1001;
		words[58] = 8'b0000_1001;
		words[59] = 8'b1111_1111;
		words[60] = 0;
		words[61] = 8'b1000_0001;
		words[62] = 8'b1000_0001;
		words[63] = 8'b1000_0001;
		words[64] = 8'b1111_1111;
		words[65] = 0;
		words[66] = 0;
		words[67] = 0;
		words[68] = 0;
		words[69] = 0;
		end
	assign in_count2 = in_count - 8;
	assign ou_c[7:0] = words[in_count2]; 
	assign ou_c[15:8] = ~words[in_count];
	clk_prog1hz cp1hz(clk, clk1);
	
	always @(posedge clk1)
		begin  
		for (i=0; i<69; i=i+1)
			words[i+1] <= words[i];
		words[0] = words[69];
		end
endmodule 
	

module binary_to_onehotN(bin, ou_o);
	parameter n = 8;
	input [2:0] bin;
	output reg[n-1:0] ou_o;
	//reg [n-1:0] Reg;
		
	always @(*)
		begin
        ou_o = 8'b1111_1111;
        ou_o[bin] = 1'b0;
		end
	//assign ou_o = Reg; 
endmodule 

module binary_to_onehotP(bin, ou_o);
	parameter n = 8;
	input [2:0] bin;
	output reg[n-1:0] ou_o;
	//reg [n-1:0] Reg;
		
	always @(*)
		begin
        ou_o = 8'd0;
        ou_o[bin] = 1'b1;
		end
	//assign ou_o = Reg; 
endmodule 

module clk_prog1khz(in_clk, clk1);//clk 500hz
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
		counter1 = counter1 + 1;
		if(counter1== 49999)
			clk1 = 1'b1;
		else if(counter1 == 99999)
			begin
			clk1 = 1'b0;
			counter1 = 0;
			end
		end
endmodule 
module clk_prog1hz(in_clk, clk1);//4HZ
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
        if(counter1 == 6249999)
          clk1 = 1'b1; 
        else if(counter1 == 12499999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule 

/*
		words[0]  = 0;
		words[1]  = 8'b1111_1111;
		words[2]  = 8'b0000_1001;
		words[3]  = 8'b0000_1001;
		words[4]  = 8'b1111_1111;
		words[5]  = 0;
		words[6]  = 8'b1000_0000;
		words[7]  = 8'b1000_0000;
		words[8]  = 8'b1000_0000;
		words[9]  = 8'b1111_1111;
		words[10] = 0;
		words[11] = 8'b1111_1111;
		words[12] = 8'b1000_0001;
		words[13] = 8'b1000_0001;
		words[14] = 8'b1111_1111;
		words[15] = 0;
		words[16] = 8'b1111_1111;
		words[17] = 8'b0000_1000;
		words[18] = 8'b0000_1000;
		words[19] = 8'b1111_1111;
		words[20] = 0;
		words[21] = 0;
		words[22] = 0;
		words[23] = 0;
		words[24] = 0;
*/