module FA_2bit_str(
    input  [1:0] A,
    input  [1:0] B,
    input        Cin,
    output [1:0] Sum,
    output       Cout
);
    wire c1;

    fa_1bit fa0 (
        .a(A[0]),
        .b(B[0]),
        .cin(Cin),
        .sum(Sum[0]),
        .cout(c1)
    );

    fa_1bit fa1 (
        .a(A[1]),
        .b(B[1]),
        .cin(c1),
        .sum(Sum[1]),
        .cout(Cout)
    );
endmodule

module fa_1bit (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
