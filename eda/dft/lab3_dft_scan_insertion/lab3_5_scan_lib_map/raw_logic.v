module raw_logic (
  input  wire clk,
  input  wire [3:0] in_a,
  input  wire [3:0] in_b,
  output wire [1:0] nor_out,
  output wire [3:0] out_q
);
  wire [3:0] nand_out;

  // 4 NAND2 gates
  assign nand_out[0] = ~(in_a[0] & in_b[0]);
  assign nand_out[1] = ~(in_a[1] & in_b[1]);
  assign nand_out[2] = ~(in_a[2] & in_b[2]);
  assign nand_out[3] = ~(in_a[3] & in_b[3]);

  // 2 NOR2 gates
  assign nor_out[0] = ~(in_a[0] | in_b[0]);
  assign nor_out[1] = ~(in_a[1] | in_b[1]);

  reg [3:0] q_reg;
  always @(posedge clk) begin
    q_reg <= nand_out;
  end

  assign out_q = q_reg;
endmodule
