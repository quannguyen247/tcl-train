module sram_mbist_top (
  input  wire clk,
  input  wire mbist_start,
  output wire mbist_done,
  output wire mbist_pass
);
  // SRAM 1024x32 with March C- BIST Controller Engine
  // M0: UpDown(w0)
  // M1: Up(r0, w1)
  // M2: Up(r1, w0)
  // M3: Down(r0, w1)
  // M4: Down(r1, w0)
  // M5: UpDown(r0)
endmodule
