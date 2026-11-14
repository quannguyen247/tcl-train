module drc_clock_test (
  input  wire clk,
  input  wire enable,
  input  wire d0,
  input  wire d1,
  output wire q0,
  output wire q1
);
  wire gated_clk;

  // Gated clock without test bypass mux!
  and (gated_clk, clk, enable);

  $_DFF_P_ u_reg_0 (
    .C(clk),
    .D(d0),
    .Q(q0)
  );

  $_DFF_P_ u_reg_1 (
    .C(gated_clk),
    .D(d1),
    .Q(q1)
  );
endmodule
