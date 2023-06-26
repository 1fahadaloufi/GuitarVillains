module ssdec (
  input logic [3:0]in,
  input logic enable,
  output logic [6:0]out
);
  logic [15:0] SEGA, SEGB, SEGC, SEGD, SEGE, SEGF, SEGG;

  assign SEGA = 16'b1101011111101101;
  assign SEGB = 16'b0010011110011111;
  assign SEGC = 16'b0010111111111011;
  assign SEGD = 16'b0111100101101101;
  assign SEGE = 16'b1111110101000101;
  assign SEGF = 16'b1101111101110001;
  assign SEGG = 16'b1110111101111100;

  assign out[0] = enable ? SEGA[in] : enable;
  assign out[1] = enable ? SEGB[in] : enable;
  assign out[2] = enable ? SEGC[in] : enable;
  assign out[3] = enable ? SEGD[in] : enable;
  assign out[4] = enable ? SEGE[in] : enable;
  assign out[5] = enable ? SEGF[in] : enable;
  assign out[6] = enable ? SEGG[in] : enable;

endmodule