module registro_multfunc (ou_q, in_d, in_clk, in_rst_n, in_preset, in_sel, in_serial);
	input in_clk, in_rst_n, in_preset, in_serial;
	input[3:0] in_sel;
    input [27:0] in_d;
    output reg[27:0] ou_q;
    reg n;
	
	always @(posedge in_clk or negedge in_rst_n or negedge in_preset )
		if (~in_preset)
		ou_q = 28'b1111_1111_1111_1111_1111_1111_1111;	
		else if (~in_rst_n)
		ou_q = 28'd0;
		else 	
			case(in_sel)
				4'b0000 : ou_q = in_d; 
				4'b0001 : begin
						  ou_q = ou_q >> 1 ;
						  ou_q[27] = in_serial;
					      end
				4'b0010 : begin
						  ou_q = ou_q << 1 ;
						  ou_q[0] = in_serial;
					      end 
				4'b0011 : ou_q = ou_q >> 1 ;
				4'b0100 : ou_q = ou_q << 1 ;
				4'b0101 : begin
						  ou_q = ou_q >> 1 ;
						  ou_q[27] = ou_q[26];
					      end
				4'b0110 : begin
						  ou_q = ou_q << 1 ;
						  ou_q[0] = ou_q[1];
					      end
				4'b0111 : begin
						  n = ou_q[0];
						  ou_q = ou_q >> 1 ;
						  ou_q[27] = n;
					      end
				4'b1000 : begin
						  n = ou_q[27];
						  ou_q = ou_q << 1 ;
						  ou_q[0] = n;
					      end
				default : ou_q = in_d;
			endcase
endmodule


/*
if (in_rst_n)
		begin
			if (in_preset)
			begin
				case(in_sel)
					4'b0000 : ou_q = in_d; 
					4'b0001 : begin
							  ou_q = ou_q >> 1 ;
							  ou_q[31] = in_serial;
						      end
					4'b0010 : begin
							  ou_q = ou_q << 1 ;
							  ou_q[0] = in_serial;
						      end 
					4'b0011 : ou_q = ou_q >> 1 ;
					4'b0100 : ou_q = ou_q << 1 ;
					4'b0101 : begin
							  ou_q = ou_q >> 1 ;
							  ou_q[31] = ou_q[30];
						      end
					4'b0110 : begin
							  ou_q = ou_q << 1 ;
							  ou_q[0] = ou_q[1];
						      end
					4'b0111 : begin
							  n = ou_q[0];
							  ou_q = ou_q >> 1 ;
							  ou_q[31] = n;
						      end
					4'b1000 : begin
							  n = ou_q[31];
							  ou_q = ou_q << 1 ;
							  ou_q[0] = n;
						      end
					default : ou_q = in_d;
				endcase
			end
			else
				ou_q = 32'b1111_1111_1111_1111_1111_1111_1111_1111;	
		end
		else
			ou_q = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
*/