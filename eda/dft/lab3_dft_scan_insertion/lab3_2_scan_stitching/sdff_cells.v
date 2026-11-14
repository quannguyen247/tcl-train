module alu_scan (
  input  wire clk,
  input  wire scan_in,
  input  wire scan_en,
  output wire scan_out
);
  wire s0, s1, s2;

  SDFF u_sdff_0 (
    .CLK(clk),
    .D(1'b0),
    .SI(1'b0),
    .SE(1'b0),
    .Q(s0)
  );

  SDFF u_sdff_1 (
    .CLK(clk),
    .D(1'b0),
    .SI(1'b0),
    .SE(1'b0),
    .Q(s1)
  );

  SDFF u_sdff_2 (
    .CLK(clk),
    .D(1'b0),
    .SI(1'b0),
    .SE(1'b0),
    .Q(s2)
  );
endmodule
