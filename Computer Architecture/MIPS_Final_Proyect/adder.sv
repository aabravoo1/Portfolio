//Andres Bravo A01630783, Mariana Gonzalez A01630948, Nicol Gomez A00227180, Brenda Esquivel A01421610
module adder(
  input  logic [7:0] data_in,
  output logic [7:0] data_out
);

  assign data_out = data_in + 8'b1;

endmodule
