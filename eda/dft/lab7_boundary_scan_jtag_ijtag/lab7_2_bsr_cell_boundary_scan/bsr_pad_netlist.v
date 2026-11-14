module chip_pad_bsr_ring (
  input  wire [0:0] pad_addr_in,
  output wire [0:0] pad_data_out,
  output wire pad_oe_n
);
  BSR_IN   u_bsr_in_0   (.PAD(pad_addr_in[0]));
  BSR_OUT  u_bsr_out_0  (.PAD(pad_data_out[0]));
  BSR_CTRL u_bsr_ctrl_0 (.PAD(pad_oe_n));
endmodule
