
import mips_pkg::*;
module dm (
              input  logic                                  clk,
              input  logic                                  we,
              input  logic [$clog2(WORDS_INSTRUCTION)-1:0]  address,
              input  logic [DATA_WIDTH-1:0]                 data_in,
              output logic [DATA_WIDTH-1:0]                 data_out
            );

logic [DATA_WIDTH-1:0] ram_mem [WORDS_INSTRUCTION]; //two dimension array


always_ff @(posedge clk) begin //everytime you use always_ff you need to use non-blocking assignment
  if(we) begin
    ram_mem[address] <= data_in;
  end
end

assign data_out = ram_mem[address];

endmodule
