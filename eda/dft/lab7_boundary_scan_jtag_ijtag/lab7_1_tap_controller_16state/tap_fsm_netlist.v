module jtag_tap_fsm_top (
  input  wire tck,
  input  wire tms,
  input  wire tdi,
  input  wire trst_n,
  output wire tdo
);
  // 16-State JTAG TAP Controller
  // Reset: Test-Logic-Reset
  // Instruction Register length: 5 bits
  // EXTEST Opcode: 5'b00001 (0x01)
endmodule
