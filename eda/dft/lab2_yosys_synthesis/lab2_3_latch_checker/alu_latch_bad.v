module alu_latch_bad (
    input [1:0] sel,
    input [7:0] a, b,
    output reg [7:0] out
);
    wire _0_;
    $_DLATCH_P_ u_latch_0 (.D(a[0]), .E(sel[0]), .Q(out[0]));
    $_DLATCH_P_ u_latch_1 (.D(a[1]), .E(sel[1]), .Q(out[1]));
    $_AND_      u_gate_0  (.A(a[2]), .B(b[2]),  .Y(out[2]));
endmodule
