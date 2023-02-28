module decoder_15_segment_tb;
	reg [5:0] in_X;
	wire[13:0] ou_B;
	reg [6:0] stimulus;
	
	segment_15 dut(
		.in_x(in_X),
		.ou_z(ou_B)
		);
	initial
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		
		for(stimulus = 0; stimulus < 64; stimulus = stimulus + 1)
			begin
				in_X = stimulus;
				#10
				$display("in_X = %b, ou_B = %b", in_X, ou_B);
		end
	end
endmodule
