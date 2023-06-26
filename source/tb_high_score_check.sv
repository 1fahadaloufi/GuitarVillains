`timescale 1ns/10ps  // the 1ns is the timescale and 10ps is the time precision

module tb_high_score_check(); 

// Define the Constant Values here
localparam FINISH = 3'b101;
localparam CLK_PERIOD = 83.33; // 83.33 ns which is roughly the 12 MHz clock of the FPGA



// Define the device signals
logic tb_clk; 
logic tb_n_rst; 
logic[3:0] tb_score; 
logic[2:0] tb_mode; 
logic[3:0] tb_highest_score; 
// we are defining the inputs and outputs (all of them) from the design module

// expected outputs
logic [3:0] tb_expected_output;


// task for resetting the DUT (device under test)
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
always begin // we never use always_comb or always_ff blocks in testbenches
    tb_clk = 1'b0; 
    #(CLK_PERIOD / 2); 
    tb_clk = 1'b1; 
    #(CLK_PERIOD / 2); 
end
// the above block generates the clock for the TESTBENCH, first it's off,
// then you wait half a duty cycle, then it's on, then wait half a duty cycle, and it's off again,
// and since it's an "always" block, this becomes the callable clock for the testbench module with a 50/50 duty cycle




// instantiate your module that you want to test

high_score_check DUT (.clk(tb_clk),
                      .n_rst(tb_n_rst), 
                      .score(tb_score),
                      .mode(tb_mode),
                      .highest_score(tb_highest_score)); 
                      // connect all inputs to inputs and outputs to outputs; testbench module connecting to actual design module




// your simulation and the start of your simulation goes here
initial begin
    // first initialize the signals at the beginning of the simulation
    tb_n_rst = 1'b1; // have the reset INACTIVE
    tb_score = 0; 
    tb_mode = 0; 
    // the values above are simply being initialized

 // Signal Dump

    // reset the device
    reset_dut(); // we reset the device because the FF has unknown value 'X' when we power it on


    // fill in the rest of the simulation here

    // ************************************************************************
    // Test Case 1
    // ************************************************************************
    // Apply test case initial stimulus
    tb_mode          = 3'b101;
    tb_score         = 4'b1101;
    // cannot set outputs of modules inside of testbench

    // Wait for a bit before checking for correct functionality
    
    @(negedge tb_clk);
    tb_expected_output = 4'b1101;

    if (tb_highest_score == tb_expected_output)
        $display("CORRECT!");
    else
        $display("WRONG!");

    tb_score = 4'b1111;
    @(negedge tb_clk); // we wait until the negedge and not the posedge because of propogation delay, so don't just wait until the next edge 

    if (tb_highest_score == 4'b1111)
        $display("good job, this module definitely works");
    else
        $display("this module does not work");


    $finish; 

end

initial begin
    $dumpfile ("dump.vcd");
    $dumpvars;
end

endmodule