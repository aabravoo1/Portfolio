module b8_full_add_tb;
	reg [7:0] in_A, in_B;
	reg in_C;
	wire[7:0] ou_S;
	wire ou_C;
	reg [16:0] stimulus;
	
	b8_full_add dut(
		.in_a(in_A),
		.in_b(in_B),
		.in_c(in_C),
		.ou_c(ou_C),
		.ou_s(ou_S)
		);
	
	initial 
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		in_C = 1'b0;
		for(stimulus = 0 ; stimulus<9; stimulus++)
			begin 
			{in_A,in_B} = stimulus;
			#10
			$display("A = %b, B = %b, in_C = %b, CS = %b", in_A, in_B, in_C, {ou_C, ou_S});
			end
		in_C = 1'b1;
		for(stimulus = 250 ; stimulus< 270; stimulus++)
			begin 
			{in_A,in_B} = stimulus;
			#10
			$display("A = %b, B = %b, in_C = %b, CS = %b", in_A, in_B, in_C, {ou_C, ou_S});
			end
		in_C = 1'b0;
		for(stimulus = 1020 ; stimulus< 1040; stimulus++)
			begin 
			{in_A,in_B} = stimulus;
			#10
			$display("A = %b, B = %b, in_C = %b, CS = %b", in_A, in_B, in_C, {ou_C, ou_S});
			end
		for(stimulus = 65520 ; stimulus< 65536; stimulus++)
			begin 
			{in_A,in_B} = stimulus;
			#10
			$display("A = %b, B = %b, in_C = %b, CS = %b", in_A, in_B, in_C, {ou_C, ou_S});
			end
	end
endmodule
		