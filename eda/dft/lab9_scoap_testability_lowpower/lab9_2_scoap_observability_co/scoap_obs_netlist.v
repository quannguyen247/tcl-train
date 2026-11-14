module scoap_obs_test (
  input  wire A,
  input  wire B,
  output wire Z
);
  and (Z, A, B);
endmodule
