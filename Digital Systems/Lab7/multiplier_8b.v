module multiplier_8b(in_a, in_b, ou_m);
	input [7:0] in_a, in_b;
	output[16:0] ou_m;
	wire[7:0] ou_m0, ou_m1, ou_m2, ou_m3, s0, s1, s2;
	wire [2:0] cou;
	
	multiplier_4b m0(in_a[3:0], in_b[3:0], ou_m0[7:0]);
	multiplier_4b m1(in_a[3:0], in_b[7:4], ou_m1[7:0]);
	multiplier_4b m2(in_a[7:4], in_b[3:0], ou_m2[7:0]);
	multiplier_4b m3(in_a[7:4], in_b[7:4], ou_m3[7:0]);
	
	b8_full_add f0(ou_m2, ou_m1, 1'b0, cou[0], s0);
	b8_full_add f1(s0, {4'b0000, ou_m0[7:4]}, 1'b0, cou[1], s1);
	b8_full_add f2(ou_m3, {3'b000, cou[0], s1[7:4]}, 1'b0, cou[2], s2);
	
	assign ou_m[0] = ou_m0[0];
	assign ou_m[1] = ou_m0[1];
	assign ou_m[2] = ou_m0[2];
	assign ou_m[3] = ou_m0[3];
	assign ou_m[4] = s1[0];
	assign ou_m[5] = s1[1];
	assign ou_m[6] = s1[2];
	assign ou_m[7] = s1[3];
	assign ou_m[8] = s2[0];
	assign ou_m[9] = s2[1];
	assign ou_m[10] = s2[2];
	assign ou_m[11] = s2[3];
	assign ou_m[12] = s2[4];
	assign ou_m[13] = s2[5];
	assign ou_m[14] = s2[6];
	assign ou_m[15] = s2[7];
	assign ou_m[16] = cou[2];
endmodule

module multiplier_4b(in_a, in_b, ou_m);
	input [3:0] in_a, in_b;
	output[7:0] ou_m;
	wire[3:0] sumA, sumB, sumC, sumD;
	wire[2:0] cou;
	wire[3:0] fa1, fa2, fa3;
	
	assign sumA[0] = in_a[0] & in_b[0]; 
	assign sumA[1] = in_a[1] & in_b[0]; 
	assign sumA[2] = in_a[2] & in_b[0]; 
	assign sumA[3] = in_a[3] & in_b[0]; 
	
	assign sumB[0] = in_a[0] & in_b[1];
	assign sumB[1] = in_a[1] & in_b[1];
	assign sumB[2] = in_a[2] & in_b[1];
	assign sumB[3] = in_a[3] & in_b[1];
	
	b4_full_add f1({1'b0, sumA[3], sumA[2], sumA[1]}, {sumB[3], sumB[2], sumB[1], sumB[0]}, 1'b0, cou[0], {fa1[3], fa1[2], fa1[1], fa1[0]});
	
	assign sumC[0] = in_a[0] & in_b[2];
	assign sumC[1] = in_a[1] & in_b[2];
	assign sumC[2] = in_a[2] & in_b[2];
	assign sumC[3] = in_a[3] & in_b[2];
	
	b4_full_add f2({cou[0], fa1[3], fa1[2], fa1[1]}, {sumC[3], sumC[2], sumC[1], sumC[0]}, 1'b0, cou[1], {fa2[3], fa2[2], fa2[1], fa2[0]});
	
	assign sumD[0] = in_a[0] & in_b[3];
	assign sumD[1] = in_a[1] & in_b[3];
	assign sumD[2] = in_a[2] & in_b[3];
	assign sumD[3] = in_a[3] & in_b[3];
	
	b4_full_add f3({cou[1], fa2[3], fa2[2], fa2[1]}, {sumD[3], sumD[2], sumD[1], sumD[0]}, 1'b0, cou[2], {fa3[3], fa3[2], fa3[1], fa3[0]});
	
	assign ou_m[0] = sumA[0];
	assign ou_m[1] = fa1[0];
	assign ou_m[2] = fa2[0];
	assign ou_m[3] = fa3[0];
	assign ou_m[4] = fa3[1];
	assign ou_m[5] = fa3[2];
	assign ou_m[6] = fa3[3];
	assign ou_m[7] = cou[2];
	
endmodule


module b8_full_add(in_a, in_b, in_c, ou_c, ou_s);
	input [7:0] in_a, in_b;
	input in_c;
	output [7:0] ou_s;
	output ou_c;
	wire cou;
	
	b4_full_add f8_0({in_a[3], in_a[2], in_a[1], in_a[0]},{in_b[3], in_b[2], in_b[1], in_b[0]}, in_c, cou, {ou_s[3], ou_s[2], ou_s[1], ou_s[0]});
	b4_full_add f8_1({in_a[7], in_a[6], in_a[5], in_a[4]},{in_b[7], in_b[6], in_b[5], in_b[4]}, cou, ou_c, {ou_s[7], ou_s[6], ou_s[5], ou_s[4]});

endmodule

module b4_full_add(in_a, in_b, in_c, ou_c, ou_s);
	input [3:0] in_a, in_b;
	input in_c;
	output [3:0] ou_s;
	output ou_c;
	wire [3:1] cou;
	
	full_add f4_0(in_a[0], in_b[0], in_c  , cou[1], ou_s[0]);
	full_add f4_1(in_a[1], in_b[1], cou[1], cou[2], ou_s[1]);
	full_add f4_2(in_a[2], in_b[2], cou[2], cou[3], ou_s[2]);
	full_add f4_3(in_a[3], in_b[3], cou[3],   ou_c, ou_s[3]);
	
endmodule

module full_add(in_a, in_b, in_c, ou_c, ou_s);
	input in_a, in_b, in_c;
	output ou_c, ou_s;
	wire ou_c, ou_s;
	
	assign ou_s = (in_a^in_b) ^ (in_c);
	assign ou_c = ((in_a^in_b)&in_c) | (in_a&in_b);
	
endmodule
	
	
	
	
	
	