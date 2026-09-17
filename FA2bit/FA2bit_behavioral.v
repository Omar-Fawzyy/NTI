module FA2bit_behavioral (
    input  [1:0] A,
    input  [1:0] B,
    input        Cin,
    output reg  [1:0] Sum,
    output reg        Cout
);
    always @(*) begin
        {Cout, Sum} = A + B + Cin;
    end
endmodule
