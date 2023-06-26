module clk_div(
  input logic clk, n_rst,
  input logic [22:0] lim,
  output logic hzX,
  output logic [22:0] counter
);
  always_ff @ (posedge clk, negedge n_rst) begin
    if (~n_rst) begin
      counter <= 0;
      hzX <= 0;
    end
    else begin
      if (counter == lim) begin
        counter <= 0;
        hzX <= 1'b1;
      end
      else begin
        counter <= counter + 1;
        hzX <= 1'b0;
      end
    end
  end
endmodule