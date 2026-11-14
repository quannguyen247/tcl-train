// Four-bit counter with one explicitly designed serial scan chain.
// Keep rst_n high throughout scan shifting and capture.
module scan_counter (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       enable,
    input  wire       scan_enable,
    input  wire       scan_in,
    output wire       scan_out,
    output wire [3:0] count
);
    reg [3:0] state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= 4'b0000;
        else if (scan_enable)
            state <= {state[2:0], scan_in};
        else if (enable)
            state <= state + 4'b0001;
    end

    assign scan_out = state[3];
    assign count = state;
endmodule
