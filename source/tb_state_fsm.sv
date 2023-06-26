`default_nettype none
`timescale 1ns/10ps

module tb_state_fsm();

    
    //Local Parameters

    localparam CLK_PERIOD = 83.33;
    localparam REST_ACTIVE = 1'b0;
    localparam REST_INACTIVE = 1'b1;
    localparam IDLE = 3'd1;
    localparam EDIT = 3'd2;
    localparam DIFF = 3'd3;
    localparam RUN = 3'd4;
    localparam PAUSE = 3'd5;
    localparam FINISH = 3'd6;
    //Inputs/Outputs for Signals for Module
    logic tb_clk;
    logic tb_n_rst;
    logic tb_pushed_3;
    logic tb_pushed_4;
    logic tb_fin_check;
    logic [2:0]tb_mode;

    //Instantiate the Module
    state_fsm DUT(.clk(tb_clk), .n_rst(tb_n_rst), .pushed_3(tb_pushed_3), .pushed_4(tb_pushed_4), .fin_check(tb_fin_check), .mode(tb_mode[2:0]));

    //Clock Generation Block

    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD / 2);
        tb_clk = 1'b1;
        #(CLK_PERIOD / 2);
    end

    //Simulation
    task check_mode;
    input logic [2:0] expected_mode;
    input string string_mode;
    begin
        @(negedge tb_clk);
            if(tb_mode == expected_mode)
                $display("Correct Mode: %s", string_mode);
            else
                $error("Incorrect mode: %b Expected %s.", tb_mode, string_mode);

            #(CLK_PERIOD);
    end
    endtask

    task single_button_press3;
    begin
        @(negedge tb_clk);
        tb_pushed_3 = 1'b1;
        @(negedge tb_clk);
        tb_pushed_3 = 1'b0;
        @(posedge tb_clk);
    end
    endtask

    task single_button_press4;
    begin
        @(negedge tb_clk);
        tb_pushed_4 = 1'b1;
        @(negedge tb_clk);
        tb_pushed_4 = 1'b0;
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
        tb_pushed_3 = 1'b0;
        tb_pushed_4 = 1'b0;
        tb_fin_check = 1'b0;

        reset_DUT();
        #(CLK_PERIOD * 5);
        single_button_press3();
        check_mode(IDLE, "IDLE");
        #(CLK_PERIOD * 5);
        check_mode(EDIT, "EDIT");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(DIFF, "DIFF");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(RUN, "RUN");
        //single_button_press3();
        #(CLK_PERIOD * 5);
        tb_fin_check = 1'b1;
        #(CLK_PERIOD * 5);
        check_mode(FINISH, "FINISH");
        #(CLK_PERIOD * 10);
        tb_fin_check = 1'b0;
        #(CLK_PERIOD * 10);
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(IDLE, "IDLE");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(EDIT, "EDIT");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(DIFF, "DIFF");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(RUN, "RUN");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(PAUSE, "PAUSE");
        single_button_press4();
        #(CLK_PERIOD * 5);
        check_mode(FINISH, "FINISH");
        single_button_press3();
        #(CLK_PERIOD * 5);
        check_mode(IDLE, "IDLE");
        single_button_press3();
        #(CLK_PERIOD * 10);
        check_mode(EDIT, "EDIT");
        single_button_press4();
        #(CLK_PERIOD * 5);
        check_mode(EDIT, "EDIT");
        #(CLK_PERIOD * 10);
        
        


        $finish;

    end
endmodule