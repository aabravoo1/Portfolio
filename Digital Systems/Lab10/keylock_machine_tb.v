module keylock_machine_tb;
	reg[3:0] in_key;
	reg in_acc, in_start, in_finish, clock;
	wire ou_closed, ou_error, w;
  wire[3:0] ou_m0, ou_m1, ou_m2, ou_m3, ou_m4, present_state;
  wire[2:0] compare, process;
	
	keylock_machine km(
		.clock(clock),
		.in_key(in_key), 
		.in_acc(in_acc), 
		.in_start(in_start),
		.in_finish(in_finish),
		.ou_closed(ou_closed),  
		.ou_error(ou_error),
        .present_state(present_state),
		.ou_m0(ou_m0), 
		.ou_m1(ou_m1), 
		.ou_m2(ou_m2), 
		.ou_m3(ou_m3), 
        .ou_m4(ou_m4),
      .w(w),
      .compare(compare), 
      .process(process)
		);
	
	initial 
		begin
		$dumpfile("v.vcd");
		$dumpvars(1);
		$monitor("M0 = %b, M1 = %b, M2 = %b, M3 = %b, M4 = %b, Key = %b, Close = %b, Error = %b, Start = %b, Finish = %b, Acc = %b, PS = %b, w = %b, compare = %b, process = %b", ou_m0, ou_m1, ou_m2, ou_m3, ou_m4, in_key, ou_closed, ou_error, in_start, in_finish, in_acc, present_state, w, compare, process);
		end
	initial
		begin
		clock = 0;
		forever
			#1 clock = ~clock;
		end
	
	initial
		begin
			#0 in_start = 1;
			   in_acc = 1;
			   in_finish = 1; 
			   in_key = 4'b0000;
			#10 in_start = 0;
          	#10 in_start = 1;
          	#10 in_acc = 0;
            #10 in_acc = 1; //1st num
			#10 in_key = 4'b0001;
			#10	in_acc = 0;
			#10 in_acc = 1; //2nd num
			#10 in_key = 4'b0010;
			#10	in_acc = 0;
			#10 in_acc = 1; //3rd num
			#10 in_key = 4'b0011;
			#10	in_acc = 0;
			#10 in_acc = 1; //4th num
			#10 in_key = 4'b0100;
			#10	in_acc = 0;
			#10 in_acc = 1; //5th num
			#10 in_finish = 0; //enter
			#10 in_finish = 1;
			
			#10	in_key = 4'b0011;
			#10 in_acc = 0;
			#10 in_acc = 1; //1st num
			#10 in_key = 4'b0000;
			#10	in_acc = 0;
			#10 in_acc = 1; //2nd num
			#10 in_key = 4'b0111;
			#10	in_acc = 0;
			#10 in_acc = 1; //3rd num
			#10 in_key = 4'b1001;
			#10	in_acc = 0;
			#10 in_acc = 1; //4th num
			#10 in_key = 4'b0100;
			#10	in_acc = 0;
			#10 in_acc = 1; //5th num
			#10 in_finish = 0; //enter
			#10 in_finish = 1;
			
			#10	in_key = 4'b0011;
			#10 in_acc = 0;
			#10 in_acc = 1; //1st num
			#10 in_key = 4'b0000;
			#10	in_acc = 0;
			#10 in_acc = 1; //2nd num
			#10 in_key = 4'b0110;
			#10	in_acc = 0;
			#10 in_acc = 1; //3rd num
			#10 in_key = 4'b1001;
			#10	in_acc = 0;
			#10 in_acc = 1; //4th num
			#10 in_key = 4'b0100;
			#10	in_acc = 0;
			#10 in_acc = 1; //5th num
			#10 in_finish = 0; //enter
			#10 in_finish = 1;
			
			#10	in_key = 4'b0011;
			#10 in_acc = 0;
			#10 in_acc = 1; //1st num
			#10 in_key = 4'b0000;
			#10	in_acc = 0;
			#10 in_acc = 1; //2nd num
			#10 in_key = 4'b0111;
			#10	in_acc = 0;
			#10 in_acc = 1; //3rd num
			#10 in_key = 4'b1001;
			#10	in_acc = 0;
			#10 in_acc = 1; //4th num
			#10 in_key = 4'b0100;
			#10	in_acc = 0;
			#10 in_acc = 1; //5th num
			#10 in_finish = 0; //enter
			#10 in_finish = 1;	
			#10 $stop;
		end
endmodule