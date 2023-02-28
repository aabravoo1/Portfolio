module keylock_machine(in_key, in_acc, in_start, in_finish, ou_closed, ou_error, present_state);
	input[3:0] in_key;
	input in_acc, in_start, in_finish;
	output reg ou_closed, ou_error;
	reg w;
    reg[2:0] compare, process;
	reg[3:0] next_state, memory[4:0];
	output reg[3:0] present_state;
  	reg fin;
	parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101, 
			  S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000, S9 = 4'b1001, S10 = 4'b1010, 
			  S11 = 4'b1011, S12 = 4'b1100, S13 = 4'b1101, S14 = 4'b1110, S15 = 4'b1111; 
	
	initial
		begin
        ou_closed = 0;
        ou_error = 0;
        w = 0;
        compare = 0;
        process = 0;
		end

  always@(*)
    begin
      if (compare > 3'b000)
            begin
            w = in_key == memory[compare-1];
            end
      else if (process > 3'b000)
			memory[process-1] = in_key;
		else 
			w = 0;
      
    end
		
  always@(negedge in_acc, negedge in_start)
		begin
		if(~in_start)
			present_state = S5; 
		else 
			present_state = next_state;
		end
	
	always@(*)
		begin
			case(present_state)
				S0: begin
                    if(w)
						next_state = S1;
				    else
						next_state = S11;
					end
				S1: begin
					if(w)
						next_state = S2;
					else
						next_state = S12;
					end
				S2: begin
					if(w)
						next_state = S3;
					else 
						next_state = S13;
					end
				S3: begin
					if(w)
						next_state = S4;
					else
						next_state = S14;
					end
				S4: begin
                    if(w)
						next_state = S5;
                    else
						next_state = S15;
					end
				S5: begin
						if(~in_finish)
						next_state = S6;
						else
						next_state = S5;
					end
				S6: begin
						next_state = S7;
					end
				S7: begin
						next_state = S8;
                    end
				S8: begin
						next_state = S9;
					end
				S9: begin
						next_state = S10;
					end
				S10: begin
						if(~in_finish)
						next_state = S0;
						else
						next_state = S10;
					end
				S11: begin
						next_state = S12;
					end
				S12: begin
						next_state = S13;
					end
                S13: begin
						next_state = S14;
					end
				S14: begin              
						next_state = S15;
					  end
				S15: begin             
						next_state = S0;
					 end
				default: next_state = S0; 
			endcase		
		end
	
	always@(*)
		begin
			case(present_state)
				S0: begin
					ou_closed = 1;
					process = 0;
					ou_error = 0;
					compare = 3'b001;
					end
				S1:begin
					ou_closed = 1;
					process = 0;
					ou_error = 0;
					compare = 3'b010;
					end
				S2:begin
					ou_closed = 1;
					process = 0;
					ou_error = 0;
					compare = 3'b011;
					end
				S3:begin
					ou_closed = 1;
					process = 0;
					ou_error = 0;
					compare = 3'b100;
					end
				S4:begin
					ou_closed = 1;
					process = 0;
					ou_error = 0;
					compare = 3'b101;
					end
				S5:begin
					ou_closed = 0;
					process = 0;
					ou_error = 0;
					compare = 3'b000;
					end
				S6: begin
					ou_closed = 0;
					process = 3'b001;
					ou_error = 0;
					compare = 0;
					end
				S7: begin
					ou_closed = 0;
					process = 3'b010;
					ou_error = 0;
					compare = 0;
					end
				S8: begin
					ou_closed = 0;
					process = 3'b011;
					ou_error = 0;
					compare = 0;
					end
				S9: begin
					ou_closed = 0;
					process = 3'b100;
					ou_error = 0;
					compare = 0;
					end
				S10:begin
					ou_closed = 0;
					process = 3'b101;
					ou_error = 0;
					compare = 0;
					end
				S15:begin
					ou_closed = 1;
					process = 0;
					ou_error = 1;
					compare = 0;
					end
				default: begin
						ou_closed = 1;
						process = 0;
						ou_error = 0;
						compare = 0;
						end
			endcase
			
		end
endmodule