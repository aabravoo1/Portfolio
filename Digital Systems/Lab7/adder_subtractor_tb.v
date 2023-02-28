module adder_subtractor_tb;
	reg[7:0] in_A, in_B;
	reg in_EN, in_C; 
	wire[7:0] ou_S;
	wire ou_C;
	reg [16:0] stimulus;
	
	adder_subtractor dut(
		.in_a(in_A),
		.in_b(in_B),
		.in_c(in_C),
		.in_en(in_EN),
		.ou_c(ou_C),
		.ou_s(ou_S)
		);
	
	initial 
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		in_C = 1'b0;
		in_EN = 1'b0;
		for(stimulus = 5120 ; stimulus< 5140; stimulus++)
			begin 
			{in_A,in_B} = stimulus;
			#10
			$display("A = %b, B = %b, in_C = %b, CS = %b, EN = %b", in_A, in_B, in_C, {ou_C, ou_S}, in_EN);
			end
		in_C = 1'b1;
		in_EN = 1'b1;
		for(stimulus = 5120 ; stimulus< 5140; stimulus++)
			begin 
			{in_A,in_B} = stimulus;
			#10
			$display("A = %b, B = %b, in_C = %b, CS = %b, EN = %b", in_A, in_B, in_C, {ou_C, ou_S}, in_EN);
			end
	end
endmodule