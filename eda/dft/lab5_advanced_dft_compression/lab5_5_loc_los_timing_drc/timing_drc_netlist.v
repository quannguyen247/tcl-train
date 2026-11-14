module at_speed_timing_drc (
  input  wire clk,
  input  wire scan_enable, // High fanout SE signal
  input  wire d0,
  output wire q0
);
  // Scan Enable Path Analysis:
  // - High Fanout net 'scan_enable' delay = 3.50 ns
  // - Max At-Speed Clock Period (1.0 GHz) = 1.00 ns
  // - LOS (Launch-on-Shift) requires SE to switch in < 1.00 ns! (VIOLATION)
  // - LOC (Launch-on-Capture) allows SE to switch in slow Shift Period (20.00 ns) -> CLEAN

  SDFF u_sdff_0 (
    .CLK(clk),
    .D(d0),
    .SE(scan_enable),
    .Q(q0)
  );
endmodule
