onerror {resume}
vlib work
vmap work
vlog -sv mips_pkg.sv adder.sv alu.sv control_unit.sv dm.sv im.sv mips.sv mux_2x1.sv program_counter.sv rf.sv zero_ext.sv tb_fibonacci.sv
vsim work.tb_fibonacci 
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fibonacci/clk
add wave -noupdate /tb_fibonacci/asyn_n_rst
add wave -noupdate -radix decimal /tb_fibonacci/dut_mips/pc12/pc
add wave -noupdate -divider Result
add wave -noupdate -radix unsigned -childformat {{{/tb_fibonacci/dut_mips/dm_i/ram_mem[0]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[1]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[2]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[3]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[4]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[5]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[6]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[7]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[8]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[9]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[10]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[11]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[12]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[13]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[14]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[15]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[16]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[17]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[18]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[19]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[20]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[21]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[22]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[23]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[24]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[25]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[26]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[27]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[28]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[29]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[30]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[31]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[32]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[33]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[34]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[35]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[36]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[37]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[38]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[39]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[40]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[41]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[42]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[43]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[44]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[45]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[46]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[47]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[48]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[49]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[50]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[51]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[52]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[53]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[54]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[55]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[56]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[57]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[58]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[59]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[60]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[61]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[62]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[63]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[64]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[65]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[66]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[67]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[68]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[69]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[70]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[71]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[72]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[73]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[74]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[75]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[76]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[77]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[78]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[79]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[80]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[81]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[82]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[83]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[84]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[85]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[86]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[87]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[88]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[89]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[90]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[91]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[92]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[93]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[94]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[95]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[96]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[97]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[98]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[99]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[100]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[101]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[102]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[103]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[104]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[105]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[106]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[107]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[108]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[109]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[110]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[111]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[112]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[113]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[114]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[115]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[116]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[117]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[118]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[119]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[120]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[121]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[122]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[123]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[124]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[125]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[126]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[127]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[128]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[129]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[130]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[131]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[132]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[133]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[134]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[135]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[136]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[137]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[138]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[139]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[140]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[141]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[142]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[143]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[144]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[145]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[146]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[147]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[148]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[149]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[150]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[151]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[152]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[153]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[154]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[155]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[156]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[157]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[158]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[159]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[160]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[161]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[162]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[163]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[164]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[165]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[166]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[167]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[168]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[169]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[170]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[171]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[172]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[173]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[174]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[175]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[176]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[177]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[178]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[179]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[180]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[181]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[182]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[183]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[184]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[185]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[186]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[187]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[188]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[189]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[190]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[191]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[192]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[193]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[194]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[195]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[196]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[197]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[198]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[199]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[200]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[201]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[202]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[203]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[204]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[205]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[206]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[207]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[208]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[209]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[210]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[211]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[212]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[213]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[214]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[215]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[216]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[217]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[218]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[219]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[220]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[221]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[222]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[223]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[224]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[225]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[226]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[227]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[228]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[229]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[230]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[231]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[232]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[233]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[234]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[235]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[236]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[237]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[238]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[239]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[240]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[241]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[242]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[243]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[244]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[245]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[246]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[247]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[248]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[249]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[250]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[251]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[252]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[253]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[254]} -radix unsigned} {{/tb_fibonacci/dut_mips/dm_i/ram_mem[255]} -radix unsigned}} -expand -subitemconfig {{/tb_fibonacci/dut_mips/dm_i/ram_mem[0]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[1]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[2]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[3]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[4]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[5]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[6]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[7]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[8]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[9]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[10]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[11]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[12]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[13]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[14]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[15]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[16]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[17]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[18]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[19]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[20]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[21]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[22]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[23]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[24]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[25]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[26]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[27]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[28]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[29]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[30]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[31]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[32]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[33]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[34]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[35]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[36]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[37]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[38]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[39]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[40]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[41]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[42]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[43]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[44]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[45]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[46]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[47]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[48]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[49]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[50]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[51]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[52]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[53]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[54]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[55]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[56]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[57]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[58]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[59]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[60]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[61]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[62]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[63]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[64]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[65]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[66]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[67]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[68]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[69]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[70]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[71]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[72]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[73]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[74]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[75]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[76]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[77]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[78]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[79]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[80]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[81]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[82]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[83]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[84]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[85]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[86]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[87]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[88]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[89]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[90]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[91]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[92]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[93]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[94]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[95]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[96]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[97]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[98]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[99]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[100]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[101]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[102]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[103]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[104]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[105]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[106]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[107]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[108]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[109]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[110]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[111]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[112]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[113]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[114]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[115]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[116]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[117]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[118]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[119]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[120]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[121]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[122]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[123]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[124]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[125]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[126]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[127]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[128]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[129]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[130]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[131]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[132]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[133]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[134]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[135]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[136]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[137]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[138]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[139]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[140]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[141]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[142]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[143]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[144]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[145]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[146]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[147]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[148]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[149]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[150]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[151]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[152]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[153]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[154]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[155]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[156]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[157]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[158]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[159]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[160]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[161]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[162]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[163]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[164]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[165]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[166]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[167]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[168]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[169]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[170]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[171]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[172]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[173]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[174]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[175]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[176]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[177]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[178]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[179]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[180]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[181]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[182]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[183]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[184]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[185]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[186]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[187]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[188]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[189]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[190]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[191]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[192]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[193]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[194]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[195]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[196]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[197]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[198]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[199]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[200]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[201]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[202]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[203]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[204]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[205]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[206]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[207]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[208]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[209]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[210]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[211]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[212]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[213]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[214]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[215]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[216]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[217]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[218]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[219]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[220]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[221]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[222]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[223]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[224]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[225]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[226]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[227]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[228]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[229]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[230]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[231]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[232]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[233]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[234]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[235]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[236]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[237]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[238]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[239]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[240]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[241]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[242]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[243]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[244]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[245]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[246]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[247]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[248]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[249]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[250]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[251]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[252]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[253]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[254]} {-radix unsigned} {/tb_fibonacci/dut_mips/dm_i/ram_mem[255]} {-radix unsigned}} /tb_fibonacci/dut_mips/dm_i/ram_mem
add wave -noupdate -divider Process
add wave -noupdate -radix unsigned /tb_fibonacci/dut_mips/register_f/registers
add wave -noupdate -divider Instructions
add wave -noupdate /tb_fibonacci/dut_mips/im1/inst_mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199738 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {458752 ps}
run 400ns