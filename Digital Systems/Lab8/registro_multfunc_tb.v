module registro_multfunc_tb;

	reg in_CLK, in_RST_n, in_PRESET, in_SERIAL;
	reg[3:0] in_SEL;
	reg [31:0]in_D;
	wire[31:0]ou_Q; 
	reg[32:0] stimulus;

registro_multfunc dut(
	.ou_q(ou_Q),
	.in_d(in_D),
	.in_clk(in_CLK),
	.in_rst_n(in_RST_n),
	.in_sel(in_SEL),
	.in_serial(in_SERIAL),
	.in_preset(in_PRESET)
	);

initial
	begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
        $monitor("sel = %b, srl = %b, prst = %b, rst_n = %b, clk = %b, d = %b, q = %b",in_SEL, in_SERIAL, in_PRESET, in_RST_n, in_CLK, in_D, ou_Q);
	end

initial //CLK
    begin
        in_CLK = 1'b0;
        forever
            #5 in_CLK = ~in_CLK;
        end


initial
	begin
      for(stimulus = 4000000; stimulus < 4000010; stimulus = stimulus + 1)
			begin 
            #5
			in_D = stimulus;
			end
			
	end
  
  initial
    begin
        #0 in_PRESET = 1; 
		#0 in_RST_n = 0; 
		#0 in_SEL = 4'b0000;//parallel in
		#0 in_SERIAL = 1;
		#20 in_RST_n = 1;
      	#0 in_PRESET = 0;
      	#20 in_PRESET = 1;
      	
		#40 in_SEL = 4'b0000;//bidirectional serial input
		    in_D = 0;
			#10 in_SEL = 4'b0001;
		#40 in_SEL = 4'b0010;
		
		#40 in_PRESET = 0;//bidirectional logic shft
		#10 in_PRESET = 1;
			#10 in_SEL = 4'b0011;
		#40 in_SEL = 4'b0100;
		
		#40 in_SEL = 4'b0000;//bidirectional arithmetic shift
			in_D = 2147483648;
			#10 in_SEL = 4'b0101;
		#40 in_SEL = 4'b0110;
		
		#40 in_SEL = 4'b0000;//circular shift
		    in_D = 51376615;
			#10 in_SEL = 4'b0111;
		#40 in_SEL = 4'b1000;
		
		#40 in_SEL = 4'b1010;//parallel in 
		
		#40 $stop;
		
    end
      
	
endmodule