//Andres Bravo A01630783, Mariana Gonzalez A01630948, Nicol Gomez A00227180, Brenda Esquivel A01421610
import mips_pkg::*;

module zero_ext
    (
    input logic [DATA_WIDTH_IN-1:0] data_in,
    output logic [DATA_WIDTH_OUT-1:0] data_out
    );

 localparam  DATA_WIDTH_DIFFERENCE = DATA_WIDTH_OUT - DATA_WIDTH_IN;

  always_comb begin
    data_out = {{DATA_WIDTH_DIFFERENCE{1'b0}}, data_in};
  end

endmodule
