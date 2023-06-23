module sync_posedge(
    input logic clk,
    input logic n_rst,
    input logic button,

    output logic posout
);
    //logic push;
    logic sync_pb;
    logic Q1;
    logic Q2;

    always_ff @(posedge clk, negedge n_rst)
    begin
        if(~n_rst)begin
            sync_pb <= 0;
            Q1 <= 0;
            Q2 <= 0;
        end
        else begin
            sync_pb <= button;
            Q1 <= sync_pb;
            Q2 <= Q1;
        end
    end

    assign posout = Q1 & ~Q2;
    /*
    always_comb
    begin
        if (Q1 && ~Q2)
            posout = 1;
        else
            posout = 0;
    end*/

endmodule