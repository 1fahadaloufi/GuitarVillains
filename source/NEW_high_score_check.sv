module NEW_high_score_check (
    input logic clk, n_rst, score_tog,
    input logic [7:0] score,
    input logic [2:0] mode,
    output logic [13:0] SS_disp
);

logic [7:0] next_high, highest_score;
logic [6:0] SEG7 [9:0];
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

always_comb begin
    SEG7[4'b0000] = 7'b0111111;
    SEG7[4'b0001] = 7'b0000110;
    SEG7[4'b0010] = 7'b1011011;
    SEG7[4'b0011] = 7'b1001111;
    SEG7[4'b0100] = 7'b1100110;
    SEG7[4'b0101] = 7'b1101101;
    SEG7[4'b0110] = 7'b1111101;
    SEG7[4'b0111] = 7'b0000111;
    SEG7[4'b1000] = 7'b1111111;
    SEG7[4'b1001] = 7'b1100111;
end

always_comb begin
    case (score_tog)
        1'b1 : SS_disp = {SEG7[highest_score[7:4]], SEG7[highest_score[3:0]]};
        1'b0 : SS_disp = {SEG7[score[7:4]], SEG7[score[3:0]]};
        default: SS_disp = {SEG7[score[7:4]], SEG7[score[3:0]]};
    endcase
end

endmodule