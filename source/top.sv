`default_nettype none

module top 
(
  // I/O ports
  input  logic hwclk, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
  logic [2:0]mode;
  assign right[2:0] = mode;
  logic [22:0]diff_speed;
  state_fsm u1(.clk(hwclk), .n_rst(~pb[0]), .pushed_3(pb[3]), .pushed_4(pb[4]), .mode(mode));
  diff_speed u2(.clk(hwclk), .n_rst(~pb[19]), .mode(mode), .pushed_1(pb[1]), .diff_speed(diff_speed), .level(left[1:0]));

endmodule