module multiplier_8b_tb;
	reg[7:0] in_A, in_B;
	wire[16:0]ou_M;
	reg[16:0] stimulus;
	
	multiplier_8b dut(
		.in_a(in_A),
		.in_b(in_B),
		.ou_m(ou_M)
		);
	
	initial 
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		for(stimulus = 51200; stimulus < 51220; stimulus++)
			begin 
			{in_A, in_B} = stimulus;
			#10
			$display("A = %b, B = %b, M = %b", in_A, in_B, ou_M);
			end
		in_A = 8'b11111111;
		in_B = 8'b11111111;
		#10
		$display("A = %b, B = %b, M = %b", in_A, in_B, ou_M);
		end
		
endmodule 
