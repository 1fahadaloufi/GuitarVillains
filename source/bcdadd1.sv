module bcdadd1 (
  input logic [3:0] a, b,
  input logic ci,
  output logic [3:0] s,
  output logic co
);
  wire [3:0] s1;
  wire x, co1, co2, co3, co4;
  fa4 add4_1(.a(a), .b(b), .ci(ci), .s(s1), .co(co1));
  assign x = co1 | (s1[3] & (s1[2] | s1[1]));
  ha ha1(.a(s1[1]), .b(x), .s(s[1]), .co(co2));
  fa fa1(.a(s1[2]), .b(x), .ci(co2), .s(s[2]), .co(co3));
  ha ha2(.a(s1[3]), .b(co3), .s(s[3]), .co(co4));
  assign co = x;
  assign s[0] = s1[0];
endmodule