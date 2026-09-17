module generic_encoder #(
    parameter  N_out   = 2,
    parameter  N_in    = (1 << N_out)
)(
    input  wire [N_in-1:0]   in,
    output reg  [N_out-1:0]  out,
    output wire              en
);

    assign en = |in;
    integer i;

    always @(*) begin
        out = {N_out{1'b0}};

        for (i = 0; i < N_in; i = i + 1) begin
            if (in[i]) begin
                out = i[N_out-1:0];
            end
        end
    end

endmodule
