module bus_controller (
  input  wire clk,
  input  wire enable,
  input  wire test_mode,
  input  wire [3:0] data_in,
  output wire [3:0] bus_out
);
  // Tri-state buffer driving internal shared bus
  $_TBUF_ u_tbuf_0 (
    .A(data_in[0]),
    .E(enable),
    .Y(bus_out[0])
  );

  $_TBUF_ u_tbuf_1 (
    .A(data_in[1]),
    .E(enable),
    .Y(bus_out[1])
  );
endmodule
