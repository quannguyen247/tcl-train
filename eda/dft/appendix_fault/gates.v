// Small gate-level fixture shared by the Fault and exhaustive-simulation labs.
module gates(input clk, input a, input b, input c, output y);
    wire n;
    AND2 u_and(.A(a), .B(b), .Y(n));
    XOR2 u_xor(.A(n), .B(c), .Y(y));
endmodule
