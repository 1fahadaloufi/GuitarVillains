module state_fsm(
    input logic clk,
    input logic n_rst,
    input logic pushed_3,
    input logic pushed_4,
    input logic [5:0]note_count,
    
    output logic [2:0]mode
);
    localparam IDLE = 3'd1;
    localparam EDIT = 3'd2;
    localparam DIFF = 3'd3;
    localparam RUN = 3'd4;
    localparam PAUSE = 3'd5;
    localparam FINISH = 3'd6;

    logic [2:0]nxt_mode;
    logic Q1;
    logic Q2;
    logic Q3;
    logic Q4;
    logic pb_3out;
    logic pb_4out;

    always_ff @( posedge clk, negedge n_rst)
    begin
        if (n_rst == 1'b0) begin
            mode <= IDLE;
            Q1 <= 0;
            Q2 <= 0;
            Q3 <= 0;
            Q4 <= 0;
        end
        else begin
            mode <= nxt_mode;
            Q1 <= pushed_3;
            Q2 <= Q1;
            Q3 <= pushed_4;
            Q4 <= Q3;
        end
    end
    
    always_comb begin
        if (Q1 && ~Q2)
            pb_3out = 1;
        else
            pb_3out = 0;
    end

    always_comb begin
        if (Q3 && ~Q4)
            pb_4out = 1;
        else
            pb_4out = 0;
    end
        
    always_comb 
    begin
        if(pb_3out == 1'b1) begin
            case(mode)
                IDLE:
                    nxt_mode = EDIT;
                EDIT:
                    nxt_mode = DIFF;
                DIFF:
                    nxt_mode = RUN;
                RUN:
                    nxt_mode = PAUSE;
                PAUSE:
                    nxt_mode = RUN;
                FINISH:
                    nxt_mode = IDLE;
                default:
                    nxt_mode = IDLE;
            endcase
        end
        else if (pb_4out == 1'b1) begin
            case(mode)
                IDLE:
                    nxt_mode = FINISH;
                EDIT:
                    nxt_mode = FINISH;
                DIFF:
                    nxt_mode = FINISH;
                RUN:
                    nxt_mode = FINISH;
                PAUSE:
                    nxt_mode = FINISH;
                default:
                    nxt_mode = FINISH;
            endcase
        end
        else begin
            if(note_count == 6'd41)
                nxt_mode = FINISH;
            else
                nxt_mode = mode;
        end
    end


endmodule