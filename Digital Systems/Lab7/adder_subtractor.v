module adder_subtractor(in_a, in_b, in_c, in_en, ou_c, ou_s);
	input [7:0] in_a, in_b;
	input in_en, in_c; 
	output[7:0] ou_s;
	output ou_c;
	wire [7:0] f;
	wire cou;
	wire in_c1;
	
	assign f[0] = in_en ^ in_b[0];
	assign f[1] = in_en ^ in_b[1];
	assign f[2] = in_en ^ in_b[2];
	assign f[3] = in_en ^ in_b[3];
	assign f[4] = in_en ^ in_b[4];
	assign f[5] = in_en ^ in_b[5];
	assign f[6] = in_en ^ in_b[6];
	assign f[7] = in_en ^ in_b[7];
	
	assign in_c1 = in_c + in_en;
	
	b4_full_add f8_0({in_a[3], in_a[2], in_a[1], in_a[0]},{f[3], f[2], f[1], f[0]}, in_c1, cou, {ou_s[3], ou_s[2], ou_s[1], ou_s[0]});
	b4_full_add f8_1({in_a[7], in_a[6], in_a[5], in_a[4]},{f[7], f[6], f[5], f[4]}, cou, ou_c, {ou_s[7], ou_s[6], ou_s[5], ou_s[4]});

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
	
	







