`timescale 1ns/1ps
module tb_stitched_scan;
    reg clk = 0;
    reg scan_in = 0;
    reg scan_en = 1;
    reg done = 0;
    wire scan_out;
    alu_scan dut (.*);
    always #5 clk = ~clk;

    task automatic shift(input logic bit_in);
        @(negedge clk); scan_in = bit_in;
        @(posedge clk); #1;
    endtask
    task automatic check_and_shift(input logic expected);
        @(negedge clk); scan_in = 0; #1;
        if (scan_out !== expected)
            $fatal(1, "scan_out expected %b, got %b", expected, scan_out);
        @(posedge clk); #1;
    endtask

    initial begin
        shift(1); shift(0); shift(1);
        check_and_shift(1); check_and_shift(0); check_and_shift(1);
        $display("PASS: stitched three-cell scan chain");
        done = 1;
    end
endmodule
