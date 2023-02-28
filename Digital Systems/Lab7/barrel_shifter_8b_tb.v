module barrel_shifter_8b_tb;
	reg[7:0] in_A;
	reg[2:0] in_S;
	wire[7:0] ou_Z;
	reg[3:0] stimulus;
	
	barrel_shifter_8b dut( 
		.in_a(in_A),
		.in_s(in_S),
		.ou_z(ou_Z)
		);
		
	initial 
		begin 
		$dumpfile("v.vcd");
		$dumpvars(1);
		in_A = 8'b11111111;
		for (stimulus = 0; stimulus < 8; stimulus++);
			begin
			in_S = stimulus;
			#10
			$display("A = %b, S = %b, Z = %b", in_A, in_S, ou_Z);
			end
		in_A = 8'b01010101;
		for (stimulus = 0; stimulus < 8; stimulus++);
			begin
			in_S = stimulus;
			#10
			$display("A = %b, S = %b, Z = %b", in_A, in_S, ou_Z);
			end
		end
endmodule 