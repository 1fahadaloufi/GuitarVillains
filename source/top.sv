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
  logic finishpulse;
  logic [7:0] score;
  
  //Sends out pulse for when notes are all finished
  finish_counter pulseout(.clk(hwclk), .n_rst(~pb[19]), .beat_clk(beat_clk), .finish(finishpulse));

  //State FSM (Switches between the states)
  //Uses pushbutton 3 and pushbuton 4
  state_fsm modetrans(.clk(hwclk), .n_rst(~pb[19]), .pushed_3(pb[3]), .pushed_4(pb[4]), .fin_check(finishpulse), .mode(mode));

  //Difficulty FSM (Lets user pick their levels)
  //Uses pushbutton 1
  diff_speed lvls(.clk(hwclk), .n_rst(~pb[19]), .mode(mode), .pushed_1(pb[1]), .diff_speed(diff_speed), .level(left[1:0]));

  //Sets the Highest Score after Each Round
  high_score_check highest_score(.clk(hwclk), .n_rst(~pb[19]), .score(score), .mode(mode), .highest_score(highest_score));

  logic [31:0] notes [1:0];
  assign notes[1] = 32'b11001100110011001100110011001100;
  assign notes[0] = 32'b10101010101010101010101010101010;

  //Scoring, keyshifting, and noteshifting all in one
  main_game game(.clk(hwclk), .n_rst(~pb[19]), .mode(mode), .notes1(notes[0]), .notes2(notes[1]), .diff(diff_speed), .button_1(pb[0]), .button_2(pb[1]), .out({ss7[3], ss7[0], ss6[3], ss6[0], ss5[3], ss5[0], ss4[3], ss4[0], ss3[3], ss3[0], ss2[3], ss2[0], ss1[3], ss1[0], ss0[3], ss0[0]}), .num_misses(left), .num_hits(right), .hit(green), .missed(red), .score(score));
  
  
  logic [4:0] position;

  //For the Song Editor

  //Displays the Song while editing
  //Uses Pushbutton 2 to toggle between the song
  //Uses Pushbutton 1 and 0 to select the note
  song_display m3 ( .toggle_state(blue), .clk(hwclk), .nrst(~pb[19]), .toggle(pb[2]), .note(pb[1:0]), .current_note({ss7,ss6,ss5,ss4}) , .position(position));
  
  //Displays the Song as it is editing
  ssdec mi6 (.in(position), .out(ss0), .tens(ss1));
  // finish_counter pulseout(.clk(hwclk), .n_rst(~pb[19]), .beat_clk(beat_clk), .finish(finishpulse));
endmodule

  // Your code goes here...
  logic [31:0] notes [1:0];
  logic [7:0] score;
  logic [2:0] mode;
  always_comb begin
    if(pb[2])
      mode = 3'b0;
    else
      mode = 3'd4;
  end

endmodule

// Add more modules down here...
