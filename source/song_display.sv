module song_display ( output logic toggle_state, input logic clk, nrst, toggle, input logic [2:0] mode,

                     input logic [1:0] note, output logic [31:0] current_note, note1, note2, output logic [4:0] position) ;

    logic [31:0]  next_display;


    song_editor um (.clk(clk), .nrst(nrst), .toggle(toggle), .note(note), .note1(note1), 
                    .note2(note2), .position(position), .toggle_state(toggle_state), .mode(mode));


    always_ff @(posedge clk, negedge nrst) begin

        if(nrst == 1'b0) begin

            current_note <= 32'b0;

        end

        else begin

            current_note <= next_display;

        end



    end



    always_comb begin

        case(toggle_state)

        0: next_display = note1;

        1: next_display = note2;

        endcase


    end



endmodule

// Add more modules down here...


