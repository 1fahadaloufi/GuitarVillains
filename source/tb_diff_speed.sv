`default_nettype none
`timescale 1ns/10ps

module tb_state_fsm();

    
    //Local Parameters

    localparam CLK_PERIOD = 83.33;
    localparam REST_ACTIVE = 1'b0;
    localparam REST_INACTIVE = 1'b1;
    localparam EASY = 2'd1;
    localparam MEDIUM = 2'd2;
    localparam HARD = 2'd3;

    //Inputs/Outputs for Signals for Module
    logic tb_clk;
    logic tb_n_rst;
    logic tb_pushed_1;
    logic [2:0]tb_mode;
    logic [22:0]tb_diff_speed;
    logic [1:0]tb_level;

    //Instantiate the Module
    diff_speed DUT(.clk(tb_clk), .n_rst(tb_n_rst), .mode(tb_mode[2:0]), .pushed_1(tb_pushed_1), .diff_speed(tb_diff_speed), .level(tb_level));
    //Clock Generation Block

    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD / 2);
        tb_clk = 1'b1;
        #(CLK_PERIOD / 2);
    end

    //Simulation
    task check_lvl;
    input logic [1:0] expected_diff_level;
    input string string_lvl;
    begin
        @(negedge tb_clk);
            if(tb_level == expected_diff_level)
                $display("Correct Mode: %s", string_lvl);
            else
                $error("Incorrect mode: %b Expected %s.", tb_level, string_lvl);

            #(CLK_PERIOD);
    end
    endtask

    task single_button_press1;
    begin
        @(negedge tb_clk);
        tb_pushed_1 = 1'b1;
        @(negedge tb_clk);
        tb_pushed_1 = 1'b0;
        @(posedge tb_clk);
    end
    endtask

    task reset_DUT;
        @(negedge tb_clk);
        tb_n_rst = REST_ACTIVE;
        @(negedge tb_clk);
        tb_n_rst = REST_INACTIVE;
    endtask

 

            
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        
        tb_n_rst = REST_INACTIVE;
        tb_pushed_1 = 1'b0;
        tb_mode = 3'd3;

        reset_DUT();
        #(CLK_PERIOD * 5);
        //single_button_press1();
        check_lvl(EASY, "EASY");
        single_button_press1();
        #(CLK_PERIOD * 5);
        check_lvl(MEDIUM, "MEDIUM");
        single_button_press1();
        #(CLK_PERIOD * 5);
        //#(CLK_PERIOD * 5);
        check_lvl(HARD, "HARD");
        #(CLK_PERIOD * 5);
        tb_mode = 3'd1;
        #(CLK_PERIOD * 5);


        check_lvl(HARD, "HARD");
        #(CLK_PERIOD * 5);
        single_button_press1();
        check_lvl(HARD, "HARD");

        #(CLK_PERIOD * 5);
        tb_mode = 3'd3;
        #(CLK_PERIOD * 5);
        single_button_press1();
        #(CLK_PERIOD * 5);
        check_lvl(EASY, "EASY");
        #(CLK_PERIOD * 10);


        $finish;

    end
endmodule