module reg_bank (
  input  wire clk,
  input  wire d0,
  input  wire d1,
  output wire q0,
  output wire q1
);
  $_DFF_P_ u_reg_0 (
    .C(clk),
    .D(d0),
    .Q(q0)
  );

  $_DFF_P_ u_reg_1 (
    .C(clk),
    .D(d1),
    .Q(q1)
  );

endmodule
