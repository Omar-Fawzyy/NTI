module tb_seven_seg;

    reg  [3:0] in_bin;
    wire [6:0] out_seg;
    reg  [6:0] expected [0:15];

    seven_seg uut (
        .in_bin(in_bin),
        .out_seg(out_seg)
    );

    initial begin
        expected[0]  = 7'b1000000;
        expected[1]  = 7'b1111001;
        expected[2]  = 7'b0100100;
        expected[3]  = 7'b0110000;
        expected[4]  = 7'b0011001;
        expected[5]  = 7'b0010010;
        expected[6]  = 7'b0000010;
        expected[7]  = 7'b1111000;
        expected[8]  = 7'b0000000;
        expected[9]  = 7'b0010000;
        expected[10] = 7'b0001000;
        expected[11] = 7'b0000011;
        expected[12] = 7'b1000110;
        expected[13] = 7'b0100001;
        expected[14] = 7'b0000110;
        expected[15] = 7'b0001110;
        in_bin = 4'h0;

    end

endmodule
