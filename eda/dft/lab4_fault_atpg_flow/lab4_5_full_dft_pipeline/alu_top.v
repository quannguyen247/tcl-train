module alu_top (
  input  wire clk,
  input  wire rst_n,
  input  wire [31:0] in_a,
  input  wire [31:0] in_b,
  output wire [31:0] alu_out
);
  reg [31:0] r_a, r_b, r_out;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      r_a   <= 32'b0;
      r_b   <= 32'b0;
      r_out <= 32'b0;
    end else begin
      r_a   <= in_a;
      r_b   <= in_b;
      r_out <= r_a + r_b;
    end
  end
  assign alu_out = r_out;
endmodule
