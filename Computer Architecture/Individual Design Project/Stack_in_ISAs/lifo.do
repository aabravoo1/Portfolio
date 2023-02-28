onerror {resume}
vlib work
vmap work
vlog -sv lifo.sv tb_lifo.sv
vsim work.tb_lifo
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate /tb_lifo/clk
add wave -noupdate /tb_lifo/asyn_n_rst
add wave -noupdate /tb_lifo/push
add wave -noupdate /tb_lifo/pop
add wave -noupdate -radix unsigned /tb_lifo/data_in
add wave -noupdate -divider Outputs/Flags
add wave -noupdate -radix unsigned /tb_lifo/data_out
add wave -noupdate /tb_lifo/full
add wave -noupdate /tb_lifo/empty
add wave -noupdate -divider {Inside Stack}
add wave -noupdate -radix unsigned -childformat {{{/tb_lifo/dut_lifo/stack[0]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[1]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[2]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[3]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[4]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[5]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[6]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[7]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[8]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[9]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[10]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[11]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[12]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[13]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[14]} -radix unsigned} {{/tb_lifo/dut_lifo/stack[15]} -radix unsigned}} -expand -subitemconfig {{/tb_lifo/dut_lifo/stack[0]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[1]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[2]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[3]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[4]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[5]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[6]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[7]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[8]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[9]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[10]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[11]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[12]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[13]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[14]} {-radix unsigned} {/tb_lifo/dut_lifo/stack[15]} {-radix unsigned}} /tb_lifo/dut_lifo/stack
add wave -noupdate /tb_lifo/dut_lifo/stack_pointer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5798 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 104
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
WaveRestoreZoom {0 ps} {104568 ps}
run 120ns