module ssdec (input logic [4:0] in, output logic [7:0] out, tens);

always_comb begin
case(in)

0: out = 8'b0111111;
1: out = 8'b0000110;
2: out = 8'b1011011;
3: out = 8'b1001111;
4: out = 8'b1100110;
5: out = 8'b1101101;
6: out = 8'b1111101;
7: out = 8'b0000111;
8: out = 8'b1111111;
9: out = 8'b1100111;

10: out = 8'b0111111;
11: out = 8'b0000110;
12: out = 8'b1011011;
13: out = 8'b1001111;
14: out = 8'b1100110;
15: out = 8'b1101101;
16: out = 8'b1111101;
17: out = 8'b0000111;
18: out = 8'b1111111;
19: out = 8'b1100111;

20: out = 8'b0111111;
21: out = 8'b0000110;
22: out = 8'b1011011;
23: out = 8'b1001111;
24: out = 8'b1100110;
25: out = 8'b1101101;
26: out = 8'b1111101;
27: out = 8'b0000111;
28: out = 8'b1111111;
29: out = 8'b1100111;

30: out = 8'b0111111;
31: out = 8'b0000110;
default: out = 8'b0;

endcase

if (in < 5'd10) begin
    tens = 8'b0111111;
end
else if(in < 5'd20)begin
    tens = 8'b0000110;
end
else if(in < 5'd30)begin
    tens = 8'b1011011;
end
else begin
    tens = 8'b1001111;
end




end

endmodule
