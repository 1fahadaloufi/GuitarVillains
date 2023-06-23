`default_nettype none 
`timescale 1ms/100us

module tb_main_game();

localparam CLK_PERIOD = 10;
localparam RST_ACTIVE = 1'b0;
localparam RST_INACTIVE = 1'b1;

logic tb_clk, tb_n_rst, tb_button_1, tb_button_2;
logic [15:0] tb_out;
logic [7:0] tb_hits, tb_misses;
logic [31:0] notes [1:0];
assign notes[1] = 32'b11001100110011001100110011001100;
assign notes[0] = 32'b10101010101010101010101010101010;

main_game game(.notes1(notes[0]), .notes2(notes[1]), .clk(tb_clk), .n_rst(tb_n_rst), .diff(23'd99), .button_1(tb_button_1), .button_2(tb_button_2), .out(tb_out), .num_misses(tb_misses), .num_hits(tb_hits));

always begin
    tb_clk = 1'b0;
    #(CLK_PERIOD / 2.0);
    tb_clk = 1'b1;
    #(CLK_PERIOD / 2.0);
end

always begin
    tb_button_1 = 1'b0;
    tb_button_2 = 1'b0;
    #(CLK_PERIOD * 88)
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b0;
    tb_button_2 = 1'b0;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b0;
    tb_button_2 = 1'b0;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b0;
    tb_button_2 = 1'b0;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
    tb_button_1 = 1'b0;
    tb_button_2 = 1'b0;
    #(CLK_PERIOD);
    tb_button_1 = 1'b1;
    tb_button_2 = 1'b1;
    #(CLK_PERIOD);
end

task reset_dut;
begin
    @(negedge tb_clk);
    tb_n_rst = 1'b0;
    @(negedge tb_clk);

    tb_n_rst = 1'b1;
end
endtask

initial begin
    $dumpfile ("dump.vcd");
    $dumpvars;
end

initial begin
    reset_dut();

    #(CLK_PERIOD * 20000);

    $finish;
end

endmodule
