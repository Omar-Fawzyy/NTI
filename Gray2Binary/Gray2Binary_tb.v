module Gray2Binary_tb;

    parameter N = 4;

    reg  [N-1:0] in_gray;
    wire [N-1:0] out_binary;

    integer i;
    integer errors;

    gray2binary #(
        .N(N)
    ) uut (
        .in_gray(in_gray),
        .out_binary(out_binary)
    );

    initial begin
        errors = 0;

        for (i = 0; i < (1 << N); i = i + 1) begin
            in_gray = i ^ (i >> 1);
            #10;

            if (out_binary !== i[N-1:0]) begin
                errors = errors + 1;
            end
        end

    end

endmodule
