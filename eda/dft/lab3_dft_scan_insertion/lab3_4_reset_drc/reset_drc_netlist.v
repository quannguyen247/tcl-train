module drc_reset_test (
  input  wire clk,
  input  wire rst_n,
  input  wire test_mode,
  input  wire internal_cond,
  input  wire d0,
  input  wire d1,
  output wire q0,
  output wire q1
);
  wire safe_rst_n;
  wire unblocked_rst_n;

  // Safe reset: ORed with test_mode -> Forced to 1 (inactive) in test mode!
  or (safe_rst_n, rst_n, test_mode);

  // Unsafe reset: ANDed with internal signal -> Can trigger unexpectedly during shift!
  and (unblocked_rst_n, rst_n, internal_cond);

  $_DFF_PN0_ u_reg_0 (
    .C(clk),
    .R(safe_rst_n),
    .D(d0),
    .Q(q0)
  );

  $_DFF_PN0_ u_reg_1 (
    .C(clk),
    .R(unblocked_rst_n),
    .D(d1),
    .Q(q1)
  );
endmodule
