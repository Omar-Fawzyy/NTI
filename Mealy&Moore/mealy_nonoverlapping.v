module mealy_nonoverlapping (
    input  wire clk,
    input  wire rst,
    input  wire in,
    output reg  out
);
    localparam S0 = 3'd0,
               S1 = 3'd1,
               S2 = 3'd2,
               S3 = 3'd3,
               S4 = 3'd4,
               S5 = 3'd5;

    reg [2:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        out = 1'b0;

        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S2 : S3;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S2 : S5;
            S5: begin
                if (in) begin
                    out = 1'b1;
                    next_state = S0; // Complete reset (no sharing)
                end else begin
                    out = 1'b0;
                    next_state = S0;
                end
            end
            default: next_state = S0;
        endcase
    end
endmodule
