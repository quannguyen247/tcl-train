module scoap_logic_test (
  input  wire A,
  input  wire B,
  output wire N_AND,
  output wire N_OR
);
  and (N_AND, A, B);
  or  (N_OR,  A, B);
endmodule
