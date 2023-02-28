onerror {resume}
vlib work
vmap work
vlog -sv mips_pkg.sv adder.sv alu.sv control_unit.sv dm.sv im.sv mips.sv mux_2x1.sv program_counter.sv rf.sv zero_ext.sv tb_mips.sv
vsim work.tb_mips
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mips/clk
add wave -noupdate /tb_mips/asyn_n_rst
add wave -noupdate -expand /tb_mips/dut_mips/register_f/registers
add wave -noupdate /tb_mips/dut_mips/dm_i/ram_mem
add wave -noupdate /tb_mips/dut_mips/pc12/pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52452845 ps} 0}
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
WaveRestoreZoom {0 ps} {76768 ps}
run 200ns
