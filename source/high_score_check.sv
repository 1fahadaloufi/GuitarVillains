// SSD LOGIC NOT IMPLEMENTED YET
// score bit width may have to be larger to accomodate for more points

module high_score_check (
    input logic clk, n_rst,
    input logic [3:0] score,
    input logic [2:0] mode,
    output logic [3:0] highest_score
);

logic [3:0] next_high;
localparam FINISH = 3'b101;

always_comb begin
    if (mode == FINISH) begin // 3'b101 = FINISH state
        if (score > highest_score)
            next_high = score;
        else
            next_high = highest_score;
    end
    else   
        next_high = highest_score;
end

always_ff @ (posedge clk, negedge n_rst) begin
    if (!n_rst)
        highest_score <= 0;
    else
        highest_score <= next_high;
end

endmodule