module barrel_shifter_8b(in_a, in_s, ou_z);
	input [7:0] in_a;
	input [2:0] in_s;
	output[7:0] ou_z;
	wire [7:0] wA, wB;
	
	mux m1_0({in_a[7], in_a[6]}, in_s[0], wA[7]);
	mux m1_1({in_a[6], in_a[5]}, in_s[0], wA[6]);
	mux m1_2({in_a[5], in_a[4]}, in_s[0], wA[5]);
	mux m1_3({in_a[4], in_a[3]}, in_s[0], wA[4]);
	mux m1_4({in_a[3], in_a[2]}, in_s[0], wA[3]);
	mux m1_5({in_a[2], in_a[1]}, in_s[0], wA[2]);
	mux m1_6({in_a[1], in_a[0]}, in_s[0], wA[1]);
	mux m1_7({in_a[0], 1'b0   }, in_s[0], wA[0]);
	
	mux m2_0({wA[7], wA[5]}, in_s[1], wB[7]);
	mux m2_1({wA[6], wA[4]}, in_s[1], wB[6]);
	mux m2_2({wA[5], wA[3]}, in_s[1], wB[5]);
	mux m2_3({wA[4], wA[2]}, in_s[1], wB[4]);
	mux m2_4({wA[3], wA[1]}, in_s[1], wB[3]);
	mux m2_5({wA[2], wA[0]}, in_s[1], wB[2]);
	mux m2_6({wA[1], 1'b0 }, in_s[1], wB[1]);
	mux m2_7({wA[0], 1'b0 }, in_s[1], wB[0]);
	
	mux m3_0({wB[7], wB[3]}, in_s[2], ou_z[7]);
	mux m3_1({wB[6], wB[2]}, in_s[2], ou_z[6]);
	mux m3_2({wB[5], wB[1]}, in_s[2], ou_z[5]);
	mux m3_3({wB[4], wB[0]}, in_s[2], ou_z[4]);
	mux m3_4({wB[3], 1'b0 }, in_s[2], ou_z[3]);
	mux m3_5({wB[2], 1'b0 }, in_s[2], ou_z[2]);
	mux m3_6({wB[1], 1'b0 }, in_s[2], ou_z[1]);
	mux m3_7({wB[0], 1'b0 }, in_s[2], ou_z[0]);
endmodule


module mux (in_a, in_s, ou_z);
	input[1:0] in_a;
	input in_s;
	output ou_z;
	
	assign ou_z = (in_s == 1'b1)? in_a[0] : in_a[1];
endmodule	
	
	
	
