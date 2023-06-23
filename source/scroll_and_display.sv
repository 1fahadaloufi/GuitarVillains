module scroll_and_display (
    input logic clk, n_rst, scroll,
    input logic [31:0] notes1, notes2,
    input logic [2:0] mode,
    output logic [39:0] padded_notes1, padded_notes2,
    output logic [15:0] out
);
  logic [39 : 0] shift1, shift2;
  logic [7:0] curr1, curr2;
  always_ff @ (posedge clk, negedge n_rst) begin
    if (~n_rst) begin
      padded_notes1 <= {8'b0, 32'b10101010101010101010101010101010};
      padded_notes2 <= {8'b0, 32'b11001100110011001100110011001100};
    end
    else begin
      padded_notes1 <= shift1;
      padded_notes2 <= shift2;
    end
  end

  always_comb begin

    if(mode == 3'd3) begin
      shift1 = {8'b0, notes1};
      shift2 = {8'b0, notes2};   
    end
    else begin
      shift1 = padded_notes1;
      shift2 = padded_notes2;   
    end   

    if(mode == 3'd4) begin
      if (scroll) begin
        shift1 = padded_notes1 << 1;
        shift2 = padded_notes2 << 1;
      end
      else begin
        shift1 = padded_notes1;
        shift2 = padded_notes2;
      end
    end


    curr1 = padded_notes1[38: 31];
    curr2 = padded_notes2[38: 31];
   
    out = {curr1[7], curr2[7], curr1[6], curr2[6],
                  curr1[5], curr2[5], curr1[4], curr2[4],
                  curr1[3], curr2[3], curr1[2], curr2[2],
                  curr1[1], curr2[1], curr1[0], curr2[0]};

  end

endmodule