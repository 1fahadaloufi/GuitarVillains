module bcdaddsub4 (
  input logic [15:0] a, b,
  input logic op,
  output logic [15:0] s
);
  wire [15:0] x, z;
  wire co;
  bcd9comp1 comp(.in(b[3:0]), .out(x[3:0]));
  bcd9comp1 comp1(.in(b[7:4]), .out(x[7:4]));
  bcd9comp1 comp2(.in(b[11:8]), .out(x[11:8]));
  bcd9comp1 comp3(.in(b[15:12]), .out(x[15:12]));
  assign z = (b & {16{~op}}) | (x & {16{op}});
  bcdadd4 addsub(.a(a), .b(z), .ci(op), .s(s), .co(co));
 
endmodule