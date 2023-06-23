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

  // Your code goes here...
  logic [31:0] notes [1:0];
  logic [7:0] score;
  assign notes[1] = 32'b11001100110011001100110011001100;
  assign notes[0] = 32'b10101010101010101010101010101010;
  main_game game(.clk(hwclk), .n_rst(~pb[19]), .mode(3'd4), .notes1(notes[0]), .notes2(notes[1]), .diff(23'd39), .button_1(pb[0]), .button_2(pb[1]), .out({ss7[3], ss7[0], ss6[3], ss6[0], ss5[3], ss5[0], ss4[3], ss4[0], ss3[3], ss3[0], ss2[3], ss2[0], ss1[3], ss1[0], ss0[3], ss0[0]}), .num_misses(left), .num_hits(right), .hit(green), .missed(red), .score(score));
endmodule

// Add more modules down here...
