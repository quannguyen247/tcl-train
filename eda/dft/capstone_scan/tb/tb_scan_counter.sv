`timescale 1ns/1ps

module tb_scan_counter;
    reg clk = 0;
    reg rst_n = 0;
    reg enable = 0;
    reg scan_enable = 0;
    reg scan_in = 0;
    reg done = 0;
    wire scan_out;
    wire [3:0] count;

    scan_counter dut (.*);
    always #5 clk = ~clk;

    task automatic expect_count(input logic [3:0] expected);
        if (count !== expected)
            $fatal(1, "count: expected %b, got %b", expected, count);
    endtask

    task automatic shift_bit(input logic bit_in, input logic expected_out);
        @(negedge clk);
        scan_enable = 1;
        scan_in = bit_in;
        #1;
        if (scan_out !== expected_out)
            $fatal(1, "scan_out: expected %b, got %b", expected_out, scan_out);
        @(posedge clk); #1;
    endtask

    initial begin
        // Drive controls away from the active edge to avoid testbench races.
        #1; expect_count(4'b0000);
        @(negedge clk); rst_n = 1; enable = 1;
        @(posedge clk); #1; expect_count(4'b0001);
        @(posedge clk); #1; expect_count(4'b0010);
        @(negedge clk); enable = 0;
        @(posedge clk); #1; expect_count(4'b0010);

        // Shift in 1011 while observing the previously captured 0010.
        shift_bit(1, 0); shift_bit(0, 0);
        shift_bit(1, 1); shift_bit(1, 0);
        expect_count(4'b1011);

        // Shift out 1011, demonstrating the chain order end to end.
        shift_bit(0, 1); shift_bit(0, 0);
        shift_bit(0, 1); shift_bit(0, 1);
        expect_count(4'b0000);

        // Return to functional mode and capture one counter transition.
        @(negedge clk); scan_enable = 0; enable = 1;
        @(posedge clk); #1; expect_count(4'b0001);
        $display("PASS: reset, functional count, hold, scan shift and capture");
        done = 1;
    end
endmodule
