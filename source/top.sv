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
  Guitar_Villains fullrun(.chip_select(1'b0), .clk(hwclk), .n_rst(~pb[19]), .button(pb[3:0]), .top_row(left[7:1]), .bottom_row(right[7:1]), .red_disp(red), .green_disp(green), .ss0(ss0[6:0]), .ss1(ss1[6:0]));
  
  //   //For EDIT DISPLAY Module
  // logic toggle1;
  // logic toggle2;
  // logic [2:0]mode;

  // //Displays the edited notes
  // logic [6:0]ed_disp1;
  // logic [6:0]ed_disp2;

  // //Displays the current position of the edit
  // logic [6:0]units;
  // logic [6:0]tens;
  // assign mode = 3'd2;
  // logic [31:0]notes[1:0];
  // song_display disp_song( .clk(hwclk), .nrst(~pb[19]), .toggle_green(green), .toggle_red(red), .toggle(pb[3]), .note(pb[1:0]), .mode(mode), .note1(notes[0]), .note2(notes[1]), .display_note1(left[6:0]), .display_note2(right[6:0]), .units(ss0[6:0]), .tens(ss1[6:0]));
endmodule




// Add more modules down here...
