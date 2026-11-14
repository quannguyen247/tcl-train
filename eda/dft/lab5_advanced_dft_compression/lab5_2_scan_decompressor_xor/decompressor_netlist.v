module scan_decompressor_top (
  input  wire [1:0] ext_si,
  output wire [3:0] int_si
);
  // Linear XOR Decompressor Network (2 External ATE Channels -> 4 Internal Chains)
  assign int_si[0] = ext_si[0];
  assign int_si[1] = ext_si[1];
  assign int_si[2] = ext_si[0] ^ ext_si[1];
  assign int_si[3] = ext_si[0] ^ ext_si[1] ^ 1'b1;
endmodule
