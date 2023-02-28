module divider_8b_tb;
	reg [7:0] in_A, in_B;
	wire[7:0] ou_R, ou_Q;
	reg [8:0] stimulus;
	
	divider_8b dut(
		.in_a(in_A),
		.in_b(in_B), 
		.ou_r(ou_R), 
		.ou_q(ou_Q)
		);
		
	initial 
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		$monitor("B = %b, A = %b, Q = %b, R = %b", in_B, in_A, ou_Q, ou_R);
		end
		
	initial 
		begin
		#0 in_A = 8'b0000_1000;
		for (stimulus = 1; stimulus < 10; stimulus = stimulus +1)
			#10 in_B = stimulus;
		#0 in_A = 8'b0001_0001;
		for (stimulus = 10; stimulus <20 ; stimulus = stimulus +1)
			#10 in_B = stimulus;
		#0 in_A = 8'b1001_0001;
		for (stimulus = 140; stimulus <150 ; stimulus = stimulus +1)
			#10 in_B = stimulus;
		
		#0 in_A = 8'b1111_1111;
		for (stimulus = 246; stimulus <256 ; stimulus = stimulus +1)
			#10 in_B = stimulus;
		end 
endmodule 
			