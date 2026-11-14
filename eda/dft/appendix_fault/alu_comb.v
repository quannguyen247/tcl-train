module alu_comb (
  input  wire clk,
  input  wire [1:0] a,
  input  wire [1:0] b,
  input  wire op,
  output wire [1:0] res
);
  wire [1:0] and_wire;
  wire [1:0] or_wire;

  assign and_wire = a & b;
  assign or_wire  = a | b;
  assign res      = op ? or_wire : and_wire;
endmodule
