module hit_scanning_and_scoring(
  input logic clk, n_rst, pushed,
  input logic [39:0] padded_notes,
  input logic [22:0] counter, lim,
  output logic [7:0] num_misses,
  output logic [7:0] num_hits,
  output logic missed, good
);
  logic [1:0] next_acc, acc;
  logic [22:0] counts, next_count;
  logic [7:0] next_num_misses, next_num_hits;
  logic start_count, next_start_count, hit, next_hit, check;

  negedge_det check_hit(.clk(clk), .n_rst(n_rst), .in(start_count), .neg_edge(check));
  always_ff @ (posedge clk, negedge n_rst) begin
    if (~n_rst) begin
      counts <= 0;
      hit <= 0;
      start_count <= 0;
      num_misses <= 0;
      num_hits <= 0;
      acc <= 0;
    end
    else begin
      acc <= next_acc;
      counts <= next_count;
      hit <= next_hit;
      start_count <= next_start_count;
      num_misses <= next_num_misses;
      num_hits <= next_num_hits;
    end
  end

  always_comb begin
    next_num_misses = num_misses;
    next_num_hits = num_hits;
    next_hit = hit;
    next_acc = acc;
    good = 1'b0;
    missed = 1'b0;
    /*
    if (padded_notes[37]) begin
      if (counter == lim - 10)
        next_start_count = 1'b1;
      else if (counter == 10)
        next_start_count = 1'b0;
      else
        next_start_count = start_count;
    end
    else if (counter == 10)
      next_start_count = 1'b0;
    else
      next_start_count = start_count;

    if (start_count) begin
      next_count = counts + 1;
      if (pushed)
        good = 1'b1;
    end
    else begin
      next_count = 0;
      if (pushed)
        missed = 1'b1;
    end
     
    if ((counts >= 1 && counts <= 3) || (counts >= 17 && counts <= 19)) begin
      if (pushed) begin
        next_hit = 1'b1;
        next_acc = 1;
      end
    end
    else if ((counts >= 4 && counts <= 6) || (counts >= 14 && counts <= 16)) begin
      if (pushed) begin
        next_hit = 1'b1;
        next_acc = 2;
      end
    end
    else if ((counts >= 7 && counts <= 13)) begin
      if (pushed) begin
        next_hit = 1'b1;
        next_acc = 3;
      end
    end 
    else begin
      if (pushed) begin
        next_num_misses = num_misses + 1;
      end
      else begin
        next_num_misses = num_misses;
      end
      next_hit = hit;
    end */
    
    if (padded_notes[37]) begin
      if (counter == lim - 1672000)
        next_start_count = 1'b1;
      else
        next_start_count = start_count;
    end
    else if (counter == 1672000)
      next_start_count = 1'b0;
    else
      next_start_count = start_count;

    if (start_count) begin
      next_count = counter + 1;
      if (pushed)
        good = 1'b1;
    end
    else begin
      next_count = 0;
      if (pushed)
        missed = 1'b1;
    end

     
    if ((counts >= 1 && counts <= 700000) || (counts >= 2244000 && counts <= 3344000)) begin
      if (pushed) begin
        next_hit = 1'b1;
        next_acc = 1;
      end
    end
    else if ((counts >= 700001 && counts <= 1284000) || (counts >= 1740000 && counts <= 2243999)) begin
      if (pushed) begin
        next_hit = 1'b1;
        next_acc = 2;
      end
    end
    else if ((counts >= 1284001 && counts <= 1739999)) begin
      if (pushed) begin
        next_hit = 1'b1;
        next_acc = 3;
      end
    end 
    else if (pushed) begin
        next_num_misses = num_misses + 1;
    end
   
    if (check) begin
      next_hit = 1'b0;
      if(hit)
        next_num_hits = num_hits + {6'b0, acc};
      else
        next_num_misses = num_misses + 1;
    end
   
  end

endmodule