module Gray2Binary #(
    parameter N = 4
)(
    input    [N-1:0] in_gray,
    output   [N-1:0] out_binary
);

    buf u_msb (out_binary[N-1], in_gray[N-1]);

    xor u_xor [N-2:0] (
        out_binary[N-2:0],
        out_binary[N-1:1],
        in_gray[N-2:0]
    );
endmodule