module FA2bit_gl (
    input  wire [1:0] A,
    input  wire [1:0] B,
    input  wire       Cin,
    output wire [1:0] Sum,
    output wire       Cout
);
    wire axor_b0, a_and_b0, axor_and_cin0;
    wire c1;

    xor (axor_b0,         A[0], B[0]);
    xor (Sum[0],          axor_b0, Cin);
    and (a_and_b0,        A[0], B[0]);
    and (axor_and_cin0,   axor_b0, Cin);
    or  (c1,              a_and_b0, axor_and_cin0);

    wire axor_b1, a_and_b1, axor_and_cin1;

    xor (axor_b1,         A[1], B[1]);
    xor (Sum[1],          axor_b1, c1);
    and (a_and_b1,        A[1], B[1]);
    and (axor_and_cin1,   axor_b1, c1);
    or  (Cout,            a_and_b1, axor_and_cin1);
endmodule
