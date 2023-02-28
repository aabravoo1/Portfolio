//Andres Bravo A01630783, Mariana Gonzalez A01630948, Nicol Gomez A00227180, Brenda Esquivel A01421610
import mips_pkg::*;

module mux_2x1 #(parameter DATA_WIDTH = 16)
    (input logic [DATA_WIDTH-1 : 0]   d0,
     input logic [DATA_WIDTH-1 : 0]   d1,
     input logic                      sel,
     output logic [DATA_WIDTH-1 : 0]  out
    );

  always_comb
	begin
		case(sel)
	    1'b0 : out = d0;
	   	1'b1 : out = d1;
        default : out = d0;
		endcase
	end

endmodule:mux_2x1
