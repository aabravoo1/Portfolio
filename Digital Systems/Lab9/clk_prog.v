module clk_prog(in_clk, clk1, clk10, clk1k, clk10k);
	input in_clk;
	output reg clk1, clk10, clk1k, clk10k; 
	reg [26:0] counter1;
	reg [23:0] counter2;
	reg [16:0] counter3;
	reg [13:0] counter4;
	
	initial 
		begin
		clk1 = 1'b0;
		clk10 = 1'b0;
		clk1k = 1'b0;
		clk10k = 1'b0;
		
		counter1 = 0;
		counter2 = 0;
		counter3 = 0;
		counter4 = 0;
		
		end

	
	always @(posedge in_clk)
		begin 
		counter1 = counter1 + 1'b1;
        if(counter1 == 24999999)
          clk1 = 1'b1; 
        else if(counter1 == 49999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
		
	always @(posedge in_clk)
		begin
		counter2 = counter2 + 1;
		if(counter2 == 2499999) 
			clk10 = 1'b1;
		else if(counter2 == 4999999)
			begin
			clk10 = 1'b0;
			counter2 = 0;
			end
		end
	
	always @(posedge in_clk)
		begin
		counter3 = counter3 + 1;
		if(counter3 == 24999)
			clk1k = 1'b1;
		else if(counter3 == 49999)
			begin
			clk1k = 1'b0;
			counter3 = 0;
			end
		end
		
	always @(posedge in_clk)
		begin
		counter4 = counter4 + 1;
		if(counter4 == 2499)
			clk10k = 1'b1;
		else if(counter4 == 4999)
			begin
			clk10k = 1'b0;
			counter4 = 0;
			end
		end

endmodule 





/*
//~~~~~~~~~~ CLK DE 1 HERZ 
module clk_prog(in_clk, clk1);
	input in_clk;
	output reg clk1; 
	reg [26:0] counter1;
	
	initial 
		begin
		clk1 = 1'b0;
		
		counter1 = 0;
		
		end
	
	always @(posedge in_clk)
		begin 
		counter1 = counter1 + 1'b1;
        if(counter1 == 24999999)
          clk1 = 1'b1; 
        else if(counter1 == 49999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule 


//~~~~~~~~~~~~~ CLK DE 5 HERZ 
 module clk_prog(in_clk, clk1);
	input in_clk;
	output reg clk1; 
	reg [26:0] counter1;
	
	initial 
		begin
		clk1 = 1'b0;
		
		counter1 = 0;
		
		end
	
	always @(posedge in_clk)
		begin 
		counter1 = counter1 + 1'b1;
        if(counter1 == 4999999)
          clk1 = 1'b1; 
        else if(counter1 == 9999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule 

module clk_prog2hz(in_clk, clk1);//2HZ
	input in_clk;
	output reg clk1; 
	reg [26:0] counter1;
	
	initial 
		begin
		clk1 = 1'b0;
		counter1 = 0;
		end
	
	always @(posedge in_clk)
		begin 
		counter1 = counter1 + 1'b1;
        if(counter1 == 12499999)
          clk1 = 1'b1; 
        else if(counter1 == 24999999)
          begin
            clk1 = 1'b0;
            counter1 = 0;
          end  
		end
endmodule 

*/