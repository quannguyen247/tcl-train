module reg_bank (clk, d, q);
    input clk;
    input [2:0] d;
    output [2:0] q;
    $_DFF_P_ _0_ (.C(clk), .D(d[0]), .Q(q[0]));
    $_DFF_P_ _1_ (.C(clk), .D(d[1]), .Q(q[1]));
    $_DFF_P_ _2_ (.C(clk), .D(d[2]), .Q(q[2]));
endmodule
