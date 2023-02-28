module b8_full_sub_tb;
	reg [7:0] in_A, in_B;
	wire[7:0] ou_S;
	reg [16:0] stimulus;
	
	b8_full_sub dut(
		.in_a(in_A),
		.in_b(in_B),
		.ou_c(ou_C),
		.ou_s(ou_S)
		);
	
	initial 
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		
		for(stimulus = 0 ; stimulus<9; stimulus++)
			begin 
			{in_B,in_A} = stimulus;
			#10
			$display("A = %b, B = %b, CS = %b", in_A, in_B, {ou_C,ou_S});
			end
			
		for(stimulus = 250 ; stimulus< 270; stimulus++)
			begin 
			{in_B,in_A} = stimulus;
			#10
			$display("A = %b, B = %b, S = %b", in_A, in_B, {ou_C,ou_S});
			end
			
		for(stimulus = 1020 ; stimulus< 1040; stimulus++)
			begin 
			{in_B,in_A} = stimulus;
			#10
			$display("A = %b, B = %b, S = %b", in_A, in_B, {ou_C,ou_S});
			end
		for(stimulus = 5000 ; stimulus< 5010; stimulus++)
			begin 
			{in_B,in_A} = stimulus;
			#10
			$display("A = %b, B = %b, S = %b", in_A, in_B, {ou_C,ou_S});
			end
			
		for(stimulus = 65520 ; stimulus< 65536; stimulus++)
			begin 
			{in_B,in_A} = stimulus;
			#10
			$display("A = %b, B = %b, S = %b", in_A, in_B, {ou_C,ou_S});
			end
	end
endmodule
		