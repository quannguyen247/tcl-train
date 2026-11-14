module alu_top (
  input  wire clk,
  input  wire scan_in,
  input  wire scan_en,
  input  wire [3:0] a,
  input  wire [3:0] b,
  output wire scan_out,
  output wire [3:0] alu_out
);
  wire [3:0] sum;
  assign sum = a + b;
  assign alu_out = sum;
  assign scan_out = scan_in;
endmodule
