module semaforo(clk, in_NSEW, in_start, ou_N, ou_S, ou_E, ou_W);
	input clk, in_start;
	input [3:0] in_NSEW;
	output reg[3:0] ou_N, ou_S, ou_E, ou_W;
	reg[3:0] present_state, next_state;
	wire clk1;
	parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000, S9 = 4'b1001,
			  SW = 4'b0101, NW = 4'b1001, SE = 4'b0110, NE = 4'b1010, 
			  NEW = 4'b1011, SEW = 4'b0111, NSE = 4'b1110, NSW = 4'b1101; 
	
	clk_prog cp1hz(clk, clk1);
	
	always@(posedge clk1 or negedge in_start)
		begin
			if(~in_start)
				present_state = S0;
			else
				present_state = next_state;
		end
		
	always@(*)
		begin
		case(present_state)
			S0: begin
				if(in_NSEW == 4'b1000)
					next_state = S0;
				else if(in_NSEW == 4'b0011 || in_NSEW == 4'b0010 || in_NSEW == 4'b0001 || in_NSEW == NW || in_NSEW == NE || in_NSEW == NEW)
					next_state = S2;
				else
					next_state = S1; 
				end
			S1: begin
				if(in_NSEW == 4'b0000)
					next_state = S1;
				else if(in_NSEW == 4'b1000)
					next_state = S0;
				else
					next_state = S2; 
				end
			S2: begin
				if(in_NSEW == 4'b0011 || in_NSEW == 4'b0010 || in_NSEW == 4'b0001 || in_NSEW == NEW || in_NSEW == NW || in_NSEW == NE || in_NSEW == 4'b1000)
					next_state = S4;
				else
					next_state = S3; 
				end
			S3: begin
				if(in_NSEW == 4'b0000 || in_NSEW == 4'b0100)
					next_state = S3;
				else
					next_state = S4;
				end
			S4: begin
				if(in_NSEW == 4'b0010 || in_NSEW == SE || in_NSEW == NE || in_NSEW == NSE)
					next_state = S8;
				else if(in_NSEW == 4'b1100 || in_NSEW == 4'b1000 || in_NSEW == 4'b0100)
					next_state = S0;
				else
					next_state = S5;
				end
			S5: begin
				if(in_NSEW == 4'b0001)
					next_state = S5;
				else if(in_NSEW == 4'b1100 || in_NSEW == 4'b1000 || in_NSEW == 4'b0100 || in_NSEW == NW || in_NSEW == SW || in_NSEW == NSE) 
					next_state = S7;
				else
					next_state = S6;
				end
			S6: begin
				if(in_NSEW == 4'b0000)
					next_state = S6;
				else if(in_NSEW == 4'b0001)
					next_state = S5;
				else
					next_state = S7;
				end
			S7: begin
				if(in_NSEW == 4'b1100 || in_NSEW == 4'b1000 || in_NSEW == 4'b0100 || in_NSEW == SW || in_NSEW == NW || in_NSEW == NSW || in_NSEW == 4'b0001)
					next_state = S9;
				else
					next_state = S8;
				end
			S8: begin
				if(in_NSEW == 4'b0000 || in_NSEW == 4'b0010)
					next_state = S8;
				else
					next_state = S9; 
				end
			S9: begin 
				if (in_NSEW == 4'b0011 || in_NSEW == 4'b0010 || in_NSEW == 4'b0001)
					next_state = S5;
				else if(in_NSEW == SW || in_NSEW == SE || in_NSEW == SEW || in_NSEW == 4'b0100)
					next_state = S3;
				else 
					next_state = S0;
				end
			default: next_state = S0; 
			endcase
		end
	
	always@(*)
		begin
			case(present_state)
				S0:begin
					ou_N = 4'b0011;
					ou_S = 4'b1000;
					ou_W = 4'b1000;
					ou_E = 4'b1000;
				   end
				S1:begin
					ou_N = 4'b0001;
					ou_S = 4'b0001;
					ou_W = 4'b1000;
					ou_E = 4'b1000;
				   end
				S2:begin
					ou_N = 4'b0100;
					ou_S = 4'b0001;
					ou_W = 4'b1000;
					ou_E = 4'b1000;
				   end
				S3:begin
					ou_N = 4'b1000;
					ou_S = 4'b0011;
					ou_W = 4'b1000;
					ou_E = 4'b1000;
				   end
				S4:begin
					ou_N = 4'b1000;
					ou_S = 4'b0100;
					ou_W = 4'b1000;
					ou_E = 4'b1000;
				   end
				S5:begin
					ou_N = 4'b1000;
					ou_S = 4'b1000;
					ou_W = 4'b0011;
					ou_E = 4'b1000;
				   end
				S6:begin
					ou_N = 4'b1000;
					ou_S = 4'b1000;
					ou_W = 4'b0001;
					ou_E = 4'b0001;
				   end
				S7:begin
					ou_N = 4'b1000;
					ou_S = 4'b1000;
					ou_W = 4'b0100;
					ou_E = 4'b0001;
				   end
				S8:begin
					ou_N = 4'b1000;
					ou_S = 4'b1000;
					ou_W = 4'b1000;
					ou_E = 4'b0011;
				   end
				S9:begin
					ou_N = 4'b1000;
					ou_S = 4'b1000;
					ou_W = 4'b1000;
					ou_E = 4'b0100;
				   end
				default:begin
						ou_N = 4'b1000;
						ou_S = 4'b1000;
						ou_W = 4'b1000;
						ou_E = 4'b1000;
						end
			endcase
		end
endmodule

module clk_prog(in_clk, clk1);//1/2 HZ
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
        if(counter1 == 49999999)
          clk1 = 1'b1; 
        else if(counter1 == 99999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule

