module divider_8b (in_a, in_b, ou_r, ou_q);
	input [7:0] in_a, in_b;
	output[7:0] ou_r, ou_q;
	
	wire [7:0] bouA, bouB, bouC, bouD, bouE, bouF, bouG, bouH, subA, subB, subC, subD, subE, subF, subG, subH, muxH;
	wire [6:0] muxA, muxB, muxC, muxD, muxE, muxF, muxG;
	
	full_sub fA0(in_a[7],in_b[0], 1'b0   , bouA[0], subA[0]);
	full_sub fA1(1'b0   ,in_b[1], bouA[0], bouA[1], subA[1]);
	full_sub fA2(1'b0   ,in_b[2], bouA[1], bouA[2], subA[2]);
	full_sub fA3(1'b0   ,in_b[3], bouA[2], bouA[3], subA[3]);
	full_sub fA4(1'b0   ,in_b[4], bouA[3], bouA[4], subA[4]);
	full_sub fA5(1'b0   ,in_b[5], bouA[4], bouA[5], subA[5]);
	full_sub fA6(1'b0   ,in_b[6], bouA[5], bouA[6], subA[6]);
	full_sub fA7(1'b0   ,in_b[7], bouA[6], bouA[7], subA[7]);
	
	mux muxA_0(subA[0], in_a[7], bouA[7], muxA[0]);
	mux muxA_1(subA[1], 1'b0   , bouA[7], muxA[1]);
	mux muxA_2(subA[2], 1'b0   , bouA[7], muxA[2]);
	mux muxA_3(subA[3], 1'b0   , bouA[7], muxA[3]);
	mux muxA_4(subA[4], 1'b0   , bouA[7], muxA[4]);
	mux muxA_5(subA[5], 1'b0   , bouA[7], muxA[5]);
	mux muxA_6(subA[6], 1'b0   , bouA[7], muxA[6]);
	
	full_sub fB0(in_a[6], in_b[0],1'b0    , bouB[0], subB[0]);
	full_sub fB1(muxA[0], in_b[1], bouB[0], bouB[1], subB[1]); 
	full_sub fB2(muxA[1], in_b[2], bouB[1], bouB[2], subB[2]); 
	full_sub fB3(muxA[2], in_b[3], bouB[2], bouB[3], subB[3]); 
	full_sub fB4(muxA[3], in_b[4], bouB[3], bouB[4], subB[4]); 
	full_sub fB5(muxA[4], in_b[5], bouB[4], bouB[5], subB[5]); 
	full_sub fB6(muxA[5], in_b[6], bouB[5], bouB[6], subB[6]); 
	full_sub fB7(muxA[6], in_b[7], bouB[6], bouB[7], subB[7]); 
	
	mux muxB_0(subB[0], in_a[6], bouB[7], muxB[0]); 
	mux muxB_1(subB[1], muxA[0], bouB[7], muxB[1]);
	mux muxB_2(subB[2], muxA[1], bouB[7], muxB[2]);
	mux muxB_3(subB[3], muxA[2], bouB[7], muxB[3]);
	mux muxB_4(subB[4], muxA[3], bouB[7], muxB[4]);
	mux muxB_5(subB[5], muxA[4], bouB[7], muxB[5]);
	mux muxB_6(subB[6], muxA[5], bouB[7], muxB[6]);
	
	full_sub fC0(in_a[5], in_b[0],1'b0    , bouC[0], subC[0]);
	full_sub fC1(muxB[0], in_b[1], bouC[0], bouC[1], subC[1]); 
	full_sub fC2(muxB[1], in_b[2], bouC[1], bouC[2], subC[2]); 
	full_sub fC3(muxB[2], in_b[3], bouC[2], bouC[3], subC[3]); 
	full_sub fC4(muxB[3], in_b[4], bouC[3], bouC[4], subC[4]); 
	full_sub fC5(muxB[4], in_b[5], bouC[4], bouC[5], subC[5]); 
	full_sub fC6(muxB[5], in_b[6], bouC[5], bouC[6], subC[6]); 
	full_sub fC7(muxB[6], in_b[7], bouC[6], bouC[7], subC[7]);
	
	mux muxC_0(subC[0], in_a[5], bouC[7], muxC[0]); 
	mux muxC_1(subC[1], muxB[0], bouC[7], muxC[1]);
	mux muxC_2(subC[2], muxB[1], bouC[7], muxC[2]);
	mux muxC_3(subC[3], muxB[2], bouC[7], muxC[3]);
	mux muxC_4(subC[4], muxB[3], bouC[7], muxC[4]);
	mux muxC_5(subC[5], muxB[4], bouC[7], muxC[5]);
	mux muxC_6(subC[6], muxB[5], bouC[7], muxC[6]);
	
	full_sub fD0(in_a[4], in_b[0],1'b0    , bouD[0], subD[0]);
	full_sub fD1(muxC[0], in_b[1], bouD[0], bouD[1], subD[1]); 
	full_sub fD2(muxC[1], in_b[2], bouD[1], bouD[2], subD[2]); 
	full_sub fD3(muxC[2], in_b[3], bouD[2], bouD[3], subD[3]); 
	full_sub fD4(muxC[3], in_b[4], bouD[3], bouD[4], subD[4]); 
	full_sub fD5(muxC[4], in_b[5], bouD[4], bouD[5], subD[5]); 
	full_sub fD6(muxC[5], in_b[6], bouD[5], bouD[6], subD[6]); 
	full_sub fD7(muxC[6], in_b[7], bouD[6], bouD[7], subD[7]);
	
	mux muxD_0(subD[0], in_a[4], bouD[7], muxD[0]); 
	mux muxD_1(subD[1], muxC[0], bouD[7], muxD[1]);
	mux muxD_2(subD[2], muxC[1], bouD[7], muxD[2]);
	mux muxD_3(subD[3], muxC[2], bouD[7], muxD[3]);
	mux muxD_4(subD[4], muxC[3], bouD[7], muxD[4]);
	mux muxD_5(subD[5], muxC[4], bouD[7], muxD[5]);
	mux muxD_6(subD[6], muxC[5], bouD[7], muxD[6]);
	
	full_sub fE0(in_a[3], in_b[0],1'b0    , bouE[0], subE[0]);
	full_sub fE1(muxD[0], in_b[1], bouE[0], bouE[1], subE[1]); 
	full_sub fE2(muxD[1], in_b[2], bouE[1], bouE[2], subE[2]); 
	full_sub fE3(muxD[2], in_b[3], bouE[2], bouE[3], subE[3]); 
	full_sub fE4(muxD[3], in_b[4], bouE[3], bouE[4], subE[4]); 
	full_sub fE5(muxD[4], in_b[5], bouE[4], bouE[5], subE[5]); 
	full_sub fE6(muxD[5], in_b[6], bouE[5], bouE[6], subE[6]); 
	full_sub fE7(muxD[6], in_b[7], bouE[6], bouE[7], subE[7]);
	
	mux muxE_0(subE[0], in_a[3], bouE[7], muxE[0]); 
	mux muxE_1(subE[1], muxD[0], bouE[7], muxE[1]);
	mux muxE_2(subE[2], muxD[1], bouE[7], muxE[2]);
	mux muxE_3(subE[3], muxD[2], bouE[7], muxE[3]);
	mux muxE_4(subE[4], muxD[3], bouE[7], muxE[4]);
	mux muxE_5(subE[5], muxD[4], bouE[7], muxE[5]);
	mux muxE_6(subE[6], muxD[5], bouE[7], muxE[6]);
	
	full_sub fF0(in_a[2], in_b[0],1'b0    , bouF[0], subF[0]);
	full_sub fF1(muxE[0], in_b[1], bouF[0], bouF[1], subF[1]); 
	full_sub fF2(muxE[1], in_b[2], bouF[1], bouF[2], subF[2]); 
	full_sub fF3(muxE[2], in_b[3], bouF[2], bouF[3], subF[3]); 
	full_sub fF4(muxE[3], in_b[4], bouF[3], bouF[4], subF[4]); 
	full_sub fF5(muxE[4], in_b[5], bouF[4], bouF[5], subF[5]); 
	full_sub fF6(muxE[5], in_b[6], bouF[5], bouF[6], subF[6]); 
	full_sub fF7(muxE[6], in_b[7], bouF[6], bouF[7], subF[7]);
	
	mux muxF_0(subF[0], in_a[2], bouF[7], muxF[0]); 
	mux muxF_1(subF[1], muxE[0], bouF[7], muxF[1]);
	mux muxF_2(subF[2], muxE[1], bouF[7], muxF[2]);
	mux muxF_3(subF[3], muxE[2], bouF[7], muxF[3]);
	mux muxF_4(subF[4], muxE[3], bouF[7], muxF[4]);
	mux muxF_5(subF[5], muxE[4], bouF[7], muxF[5]);
	mux muxF_6(subF[6], muxE[5], bouF[7], muxF[6]);
	
	full_sub fG0(in_a[1], in_b[0],1'b0    , bouG[0], subG[0]);
	full_sub fG1(muxF[0], in_b[1], bouG[0], bouG[1], subG[1]); 
	full_sub fG2(muxF[1], in_b[2], bouG[1], bouG[2], subG[2]); 
	full_sub fG3(muxF[2], in_b[3], bouG[2], bouG[3], subG[3]); 
	full_sub fG4(muxF[3], in_b[4], bouG[3], bouG[4], subG[4]); 
	full_sub fG5(muxF[4], in_b[5], bouG[4], bouG[5], subG[5]); 
	full_sub fG6(muxF[5], in_b[6], bouG[5], bouG[6], subG[6]); 
	full_sub fG7(muxF[6], in_b[7], bouG[6], bouG[7], subG[7]);
	
	mux muxG_0(subG[0], in_a[1], bouG[7], muxG[0]); 
	mux muxG_1(subG[1], muxF[0], bouG[7], muxG[1]);
	mux muxG_2(subG[2], muxF[1], bouG[7], muxG[2]);
	mux muxG_3(subG[3], muxF[2], bouG[7], muxG[3]);
	mux muxG_4(subG[4], muxF[3], bouG[7], muxG[4]);
	mux muxG_5(subG[5], muxF[4], bouG[7], muxG[5]);
	mux muxG_6(subG[6], muxF[5], bouG[7], muxG[6]);
	
	full_sub fH0(in_a[0], in_b[0],1'b0    , bouH[0], subH[0]);
	full_sub fH1(muxG[0], in_b[1], bouH[0], bouH[1], subH[1]); 
	full_sub fH2(muxG[1], in_b[2], bouH[1], bouH[2], subH[2]); 
	full_sub fH3(muxG[2], in_b[3], bouH[2], bouH[3], subH[3]); 
	full_sub fH4(muxG[3], in_b[4], bouH[3], bouH[4], subH[4]); 
	full_sub fH5(muxG[4], in_b[5], bouH[4], bouH[5], subH[5]); 
	full_sub fH6(muxG[5], in_b[6], bouH[5], bouH[6], subH[6]); 
	full_sub fH7(muxG[6], in_b[7], bouH[6], bouH[7], subH[7]);
	
	mux muxH_0(subH[0], in_a[0], bouH[7], muxH[0]); 
	mux muxH_1(subH[1], muxG[0], bouH[7], muxH[1]);
	mux muxH_2(subH[2], muxG[1], bouH[7], muxH[2]);
	mux muxH_3(subH[3], muxG[2], bouH[7], muxH[3]);
	mux muxH_4(subH[4], muxG[3], bouH[7], muxH[4]);
	mux muxH_5(subH[5], muxG[4], bouH[7], muxH[5]);
	mux muxH_6(subH[6], muxG[5], bouH[7], muxH[6]);
	mux muxH_7(subH[7], muxG[5], bouH[7], muxH[7]);
	
	assign ou_r[7] = muxH[7];
	assign ou_r[6] = muxH[6];
	assign ou_r[5] = muxH[5];
	assign ou_r[4] = muxH[4];
	assign ou_r[3] = muxH[3];
	assign ou_r[2] = muxH[2];
	assign ou_r[1] = muxH[1];
	assign ou_r[0] = muxH[0];
	
	assign ou_q[7] = ~bouA[7];
	assign ou_q[6] = ~bouB[7];
	assign ou_q[5] = ~bouC[7];
	assign ou_q[4] = ~bouD[7];
	assign ou_q[3] = ~bouE[7];
	assign ou_q[2] = ~bouF[7];
	assign ou_q[1] = ~bouG[7];
	assign ou_q[0] = ~bouH[7];
	
endmodule 
	
	
module divider_4b (in_a, in_b, ou_r, ou_q);
	input [3:0] in_a, in_b;
	output[3:0] ou_r, ou_q;
	
	wire [3:0] bouA, bouB, bouC, bouD, subA, subB, subC, subD, muxF;
	wire [2:0] muxA, muxB, muxC;
	
	full_sub fA0(in_a[3], in_b[0], 1'b0   , bouA[0], subA[0]); 
	full_sub fA1(1'b0   , in_b[1], bouA[0], bouA[1], subA[1]);
	full_sub fA2(1'b0   , in_b[2], bouA[1], bouA[2], subA[2]);
	full_sub fA3(1'b0   , in_b[3], bouA[2], bouA[3], subA[3]);
	
	mux mux1_0(subA[0], in_a[3], bouA[3], muxA[0]);
	mux mux1_1(subA[1], 1'b0   , bouA[3], muxA[1]);
	mux mux1_2(subA[2], 1'b0   , bouA[3], muxA[2]);
	
	full_sub fB0(in_a[2], in_b[0], 1'b0   , bouB[0], subB[0]);
	full_sub fB1(muxA[0], in_b[1], bouB[0], bouB[1], subB[1]);
	full_sub fB2(muxA[1], in_b[2], bouB[1], bouB[2], subB[2]);
	full_sub fB3(muxA[2], in_b[3], bouB[2], bouB[3], subB[3]);
	
	mux mux2_0(subB[0], in_a[2], bouB[3], muxB[0]);
	mux mux2_1(subB[1], muxA[0], bouB[3], muxB[1]);
	mux mux2_2(subB[2], muxA[1], bouB[3], muxB[2]);
	
	full_sub fC0(in_a[1], in_b[0], 1'b0   , bouC[0], subC[0]);
	full_sub fC1(muxB[0], in_b[1], bouC[0], bouC[1], subC[1]);
	full_sub fC2(muxB[1], in_b[2], bouC[1], bouC[2], subC[2]);
	full_sub fC3(muxB[2], in_b[3], bouC[2], bouC[3], subC[3]);
	
	mux mux3_0(subC[0], in_a[1], bouC[3], muxC[0]);
	mux mux3_1(subC[1], muxB[0], bouC[3], muxC[1]);
	mux mux3_2(subC[2], muxB[1], bouC[3], muxC[2]);
	
	full_sub fD0(in_a[0], in_b[0], 1'b0   , bouD[0], subD[0]);
	full_sub fD1(muxC[0], in_b[1], bouD[0], bouD[1], subD[1]);
	full_sub fD2(muxC[1], in_b[2], bouD[1], bouD[2], subD[2]);
	full_sub fD3(muxC[2], in_b[3], bouD[2], bouD[3], subD[3]);
	
	mux muxF_0(subD[0], in_a[0], bouD[3], muxF[0]);
	mux muxF_1(subD[1], muxC[0], bouD[3], muxF[1]);
	mux muxF_2(subD[2], muxC[1], bouD[3], muxF[2]);
	mux muxF_3(subD[3], muxC[2], bouD[3], muxF[3]);
	
	assign ou_r[3] = muxF[3];
	assign ou_r[2] = muxF[2];
	assign ou_r[1] = muxF[1];
	assign ou_r[0] = muxF[0];
	
	assign ou_q[3] = ~bouA[3];
	assign ou_q[2] = ~bouB[3];
	assign ou_q[1] = ~bouC[3];
	assign ou_q[0] = ~bouD[3];

endmodule	

module full_sub(in_a, in_b, in_bor, ou_bor, ou_d);
	input in_a, in_b, in_bor;
	output  ou_bor, ou_d;
	
	assign ou_d = (in_a ^ in_b) ^ in_bor;
	assign ou_bor = ((in_a ~^ in_b) & in_bor) | (~in_a & in_b);
	
endmodule 

module mux(in_a, in_b, in_s, ou_s);
	input in_a, in_b, in_s;
	output ou_s; 
	
	assign ou_s = (in_s == 1'b1)? in_b : in_a;
	
endmodule

