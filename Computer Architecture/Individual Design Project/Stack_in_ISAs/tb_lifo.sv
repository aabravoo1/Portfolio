module tb_lifo;

parameter DATA_WIDTH  = 6;
parameter STACK_DEPTH = 16;

logic                    clk;
logic                    asyn_n_rst;
logic                    push;
logic                    pop;
logic [DATA_WIDTH-1 : 0] data_in;
logic [DATA_WIDTH-1 : 0] data_out;
logic                    full;
logic                    empty; 

lifo #(.DATA_WIDTH(DATA_WIDTH),
	   .STACK_DEPTH(STACK_DEPTH)) 
	   
dut_lifo(.*);

initial 
	begin
		pop        = 1'b0;
		push       = 1'b0; 
		asyn_n_rst = 1'b1; #4ns;
		asyn_n_rst = 1'b0; #2ns;
		asyn_n_rst = 1'b1; #2ns;
		
		pop = 1'b1; #2ns 
		data_in = 16'd1; push = 1'b1; #2ns;
		push = 1'b0; pop = 1'b1; #2ns;
		
		data_in = 16'd1; push = 1'b1; #2ns;
		data_in = 16'd2; push = 1'b1; #2ns;
		data_in = 16'd3; push = 1'b1; #2ns;
		push = 1'b0; pop = 1'b1; #2ns;
		pop = 1'b1; #2ns;
		pop = 1'b1; #2ns;
		
		data_in = 16'd36; push = 1'b1; #2ns;
		pop = 1'b1; #40ns;
		push = 1'b0; #40ns;
		
	end
	
	
always
	begin
	clk = 1'b0; #1ns;
	clk = 1'b1; #1ns;
	end
	
endmodule 

/*
vlib work
vmap work
vlog -sv lifo.sv tb_lifo.sv
vsim work.tb_lifo

run 150ns
*/