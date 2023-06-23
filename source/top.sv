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

logic [4:0] position;
logic [2:0] mode;
logic [31:0] note1, note2;
song_display m3 ( .toggle_state(blue), .clk(hwclk), .nrst(~pb[2]), .toggle(pb[19]),
                  .note1(note1), .note2(note2), .mode(mode),
                      .note(pb[1:0]), .current_note({ss7,ss6,ss5,ss4}) , .position(position));
ssdec mi6 (.in(position), .out(ss0), .tens(ss1));
  

endmodule



// Add more modules down here...





