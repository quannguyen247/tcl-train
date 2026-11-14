module spatial_compactor_xmask (
  input  wire [3:0] int_so,
  input  wire [3:0] mask_ctrl,
  output wire [1:0] ext_so
);
  // Source of Unknown state (e.g., Analog IP / Non-scan RAM output)
  // u_analog_ip/Q drives int_so[2] -> Unknown (X-State)!

  wire [3:0] masked_so;

  // X-Masking AND gates
  and u_mask_gate_0 (masked_so[0], int_so[0], mask_ctrl[0]);
  and u_mask_gate_1 (masked_so[1], int_so[1], mask_ctrl[1]);
  and u_mask_gate_2 (masked_so[2], int_so[2], mask_ctrl[2]);
  and u_mask_gate_3 (masked_so[3], int_so[3], mask_ctrl[3]);

  // Spatial XOR Compactor Network
  assign ext_so[0] = masked_so[0] ^ masked_so[1];
  assign ext_so[1] = masked_so[2] ^ masked_so[3];
endmodule
