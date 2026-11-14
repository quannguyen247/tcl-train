// Thiết kế mẫu tổng hợp dùng cho Appendix Yosys

// 1. Mạch tổ hợp
module sample_comb (
  input  wire [1:0] a,
  input  wire [1:0] b,
  output wire [1:0] y_and,
  output wire [1:0] y_xor
);
  assign y_and = a & b;
  assign y_xor = a ^ b;
endmodule

// 2. Thanh ghi tuần tự
module sample_seq (
  input  wire clk,
  input  wire rst,
  input  wire [1:0] d,
  output reg  [1:0] q
);
  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= 2'b00;
    else
      q <= d;
  end
endmodule

// 3. Máy trạng thái (FSM)
module sample_fsm (
  input  wire clk,
  input  wire rst,
  input  wire in_event,
  output reg  out_act
);
  localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
  reg [1:0] state, next_state;

  always @(posedge clk or posedge rst) begin
    if (rst) state <= S0;
    else     state <= next_state;
  end

  always @(*) begin
    case (state)
      S0: next_state = in_event ? S1 : S0;
      S1: next_state = S2;
      S2: next_state = S0;
      default: next_state = S0;
    endcase
  end

  always @(*) begin
    out_act = (state == S2);
  end
endmodule

// 4. Mảng nhớ (RAM)
module sample_mem (
  input  wire clk,
  input  wire we,
  input  wire [1:0] addr,
  input  wire [3:0] din,
  output reg  [3:0] dout
);
  reg [3:0] ram [0:3];

  always @(posedge clk) begin
    if (we) ram[addr] <= din;
    dout <= ram[addr];
  end
endmodule

// 5. Module đỉnh liên kết
module sample_top (
  input  wire clk,
  input  wire rst,
  input  wire [1:0] a,
  input  wire [1:0] b,
  output wire [1:0] y_and,
  output wire [1:0] y_xor,
  output wire [1:0] q_out
);
  sample_comb u_comb (.a(a), .b(b), .y_and(y_and), .y_xor(y_xor));
  sample_seq  u_seq  (.clk(clk), .rst(rst), .d(y_and), .q(q_out));
endmodule
