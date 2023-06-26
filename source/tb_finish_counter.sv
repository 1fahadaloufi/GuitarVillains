`timescale 1ns/10ps  

module tb_finish_counter(); 

// Define the Constant Values here
localparam FINISH = 3'b101;
localparam CLK_PERIOD = 83.33;

// Define the device signals
logic tb_clk; 
logic tb_n_rst; 
logic tb_beat_clk;
logic tb_finish;
logic [5:0] tb_nxt_pulse;
logic [5:0] tb_fin_pulse;

// expected outputs
logic tb_expected_output;

// asserts the reset (1'b0) for one clock cycle
task reset_dut; // this is the "task" (basically similar to a callable function) that resets the FFs -- can be called at anytime
begin
    @(negedge tb_clk); 
    tb_n_rst = 1'b0; 
    @(negedge tb_clk); 
    tb_n_rst = 1'b1; 
end
endtask

// Clock generation block
always begin 
    tb_clk = 1'b0; 
    #(CLK_PERIOD / 2); 
    tb_clk = 1'b1; 
    #(CLK_PERIOD / 2); 
end

finish_counter DUT (.clk(tb_clk),
                      .n_rst(tb_n_rst), 
                      .beat_clk(tb_beat_clk),
                      .finish(tb_finish)); 

initial begin
    tb_n_rst = 1'b1;
    tb_beat_clk = 0;
    
    reset_dut();

//     tb_beat_clk = 1;
//     tb_nxt_pulse = 6'd40;
//     tb_fin_pulse = 6'd40;

//     @(negedge tb_clk)
//     tb_expected_output = 0;

//     if (tb_finish == tb_expected_output)
//         $display("first check is CORRECT");
//     else    
//         $display("first check is INCORRECT");

    tb_beat_clk = 1;
    repeat(84) begin
        @(posedge tb_clk);
    end
    // tb_nxt_pulse = 6'd41;
    // tb_fin_pulse = 6'd41;
    // #(CLK_PERIOD * 5);

    // @(negedge tb_clk);
    // #(CLK_PERIOD * 5);
    // @(negedge tb_clk);

    if (tb_finish == tb_expected_output)
        $display("final check is CORRECT");
    else
        $display("final check is INCORRECT");

    $finish;
end

initial begin
    $dumpfile ("dump.vcd");
    $dumpvars;
end

endmodule