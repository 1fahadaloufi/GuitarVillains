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



// task for resetting the DUT (device under test)
// asserts the reset (1'b0) for one clock cycle
task reset_dut;
begin
    @(negedge tb_clk); 
    tb_n_rst = 1'b0; 
    @(negedge tb_n_rst); 
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




// instantiate your module that you want to test

high_score_check DUT (.clk(tb_clk),
                      .n_rst(tb_n_rst), 
                      .score(tb_score),
                      .mode(tb_mode),
                      .highest_score(tb_highest_score)); 




// your simulation and the start of your simulation goes here
initial begin
    // first initialize the signals at the beginning of the simulation
    tb_n_rst = 1'b1; // have the reset INACTIVE
    tb_score = 0; 
    tb_mode = 0; 
    tb_highest_score = 0;


    // reset the device
    reset_dut(); 


    // fill in the rest of the simulation here

end
    










endmodule