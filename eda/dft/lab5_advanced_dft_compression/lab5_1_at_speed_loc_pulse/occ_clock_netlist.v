module at_speed_occ_test (
  input  wire ate_clk_slow,
  input  wire pll_clk_fast,
  input  wire scan_enable,
  input  wire test_mode,
  input  wire d0,
  input  wire d1,
  output wire q0,
  output wire q1
);
  wire occ_fast_clock;

  // On-Chip Clock Controller (OCC) for Launch-on-Capture (LOC) At-Speed Clocking
  OCC_CELL u_occ_top (
    .SLOW_CLK(ate_clk_slow),
    .FAST_CLK(pll_clk_fast),
    .SE(scan_enable),
    .TEST_MODE(test_mode),
    .OUT_CLK(occ_fast_clock)
  );

  $_DFF_P_ u_reg_0 (
    .C(occ_fast_clock),
    .D(d0),
    .Q(q0)
  );

  $_DFF_P_ u_reg_1 (
    .C(occ_fast_clock),
    .D(d1),
    .Q(q1)
  );
endmodule
