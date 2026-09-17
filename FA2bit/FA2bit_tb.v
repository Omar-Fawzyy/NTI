module FA2bit_tb;

    reg  [1:0] A;
    reg  [1:0] B;
    reg        Cin;

    wire [1:0] sum_str;
    wire       cout_str;

    wire [1:0] sum_beh;
    wire       cout_beh;

    wire [1:0] sum_gate;
    wire       cout_gate;

    integer i;

    FA_2bit_str uut_str (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(sum_str),
        .Cout(cout_str)
    );

    FA2bit_behavioral uut_beh (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(sum_beh),
        .Cout(cout_beh)
    );

    FA2bit_gl uut_gate (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(sum_gate),
        .Cout(cout_gate)
    );

    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            {A, B, Cin} = i[4:0];
            #10;
        end

    end

endmodule
