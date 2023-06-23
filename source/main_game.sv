module main_game (
  input logic [31 : 0] notes1, notes2,
  input logic [2:0] mode,
  input logic clk, n_rst, button_1, button_2, 
  input logic [22:0] diff,
  output logic [15:0] out,
  output logic [7:0] num_misses, num_hits, score,
  output logic hit, missed
);
  logic [39 : 0] padded_notes1, padded_notes2;
  logic [22:0] counter;
  logic [7:0] num_hits_1, num_misses_1, num_hits_2, num_misses_2;
  logic scroll, pushed_1, pushed_2, hit_1, hit_2, missed_1, missed_2;
  clk_div speed(.clk(clk), .n_rst(n_rst), .lim(diff), .hzX(scroll), .counter(counter));

  sync_posedge edge_button_1(.clk(clk), .n_rst(n_rst), .button(button_1), .posout(pushed_1));
  sync_posedge edge_button_2(.clk(clk), .n_rst(n_rst), .button(button_2), .posout(pushed_2));
 
  scroll_and_display play_song(.clk(clk), .n_rst(n_rst), .scroll(scroll), .notes1(notes1), .notes2(notes2), .padded_notes1(padded_notes1), .padded_notes2(padded_notes2), .out(out));

  hit_scanning_and_scoring scoring_button_1(.clk(clk), .n_rst(n_rst), .pushed(pushed_1), .lim(diff), .padded_notes(padded_notes1), .counter(counter), .num_misses(num_misses_1), .num_hits(num_hits_1), .missed(missed_1), .good(hit_1));
  
  hit_scanning_and_scoring scoring_button_2(.clk(clk), .n_rst(n_rst), .pushed(pushed_2), .lim(diff), .padded_notes(padded_notes2), .counter(counter), .num_misses(num_misses_2), .num_hits(num_hits_2), .missed(missed_2), .good(hit_2));

  assign num_hits = num_hits_1 + num_hits_2;
  assign num_misses = num_misses_1 + num_misses_2;

  assign score = num_hits - num_misses;

  assign missed  = missed_1 | missed_2;
  assign hit = hit_1 | hit_2;
 
endmodule
