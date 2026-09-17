module alu_8bit_tb;

    reg  [7:0]  A;
    reg  [7:0]  B;
    reg         Cin;
    reg  [4:0]  Control;
    wire [15:0] Out;

    alu_8bit uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Control(Control),
        .Out(Out)
    );

    task check_op(input [4:0] ctrl, input [7:0] in_a, input [7:0] in_b, input in_cin, input [255:0] op_name);
        begin
            Control = ctrl;
            A = in_a;
            B = in_b;
            Cin = in_cin;
            #10;
        end
    endtask

    initial begin
        check_op(5'b00000, 8'd25,  8'd10,  1'b0, "ADD");
        check_op(5'b00000, 8'hFF,  8'h01,  1'b0, "ADD (Overflow Edge)");
        check_op(5'b00001, 8'd25,  8'd10,  1'b1, "ADD with Carry");
        check_op(5'b00010, 8'd50,  8'd20,  1'b0, "SUB");
        check_op(5'b00010, 8'd10,  8'd20,  1'b0, "SUB (Negative Edge)");
        check_op(5'b00011, 8'd50,  8'd20,  1'b0, "SUB with borrow");
        check_op(5'b00100, 8'hFE,  8'd0,   1'b0, "INC A");
        check_op(5'b00100, 8'hFF,  8'd0,   1'b0, "INC A (Overflow Edge)");
        check_op(5'b00101, 8'h01,  8'd0,   1'b0, "DEC A");
        check_op(5'b00101, 8'h00,  8'd0,   1'b0, "DEC A (Underflow Edge)");
        check_op(5'b00110, 8'd15,  8'd10,  1'b0, "MAC");
        check_op(5'b00110, 8'hFF,  8'hFF,  1'b0, "MAC (Max Edge)");

        check_op(5'b00111, 8'b1100_1010, 8'b1010_1100, 1'b0, "AND");
        check_op(5'b01000, 8'b1100_1010, 8'b1010_1100, 1'b0, "OR");
        check_op(5'b01001, 8'b1100_1010, 8'b1010_1100, 1'b0, "XOR");
        check_op(5'b01010, 8'b1010_1010, 8'd0,         1'b0, "NOT A");
        check_op(5'b01011, 8'b1100_1010, 8'b1010_1100, 1'b0, "A NAND B");

        check_op(5'b01100, 8'b1001_0011, 8'd3,  1'b0, "Shift Left Logical");
        check_op(5'b01100, 8'b1001_0011, 8'd9,  1'b0, "SLL (Shift > 7 Edge)");
        check_op(5'b01101, 8'b1001_0011, 8'd2,  1'b0, "Shift Right Logical");
        check_op(5'b01110, 8'b1001_0011, 8'd2,  1'b0, "Shift Left Arith");
        check_op(5'b01111, 8'b1001_0011, 8'd3,  1'b0, "Shift Right Arith (Neg)");
        check_op(5'b01111, 8'b0101_0011, 8'd3,  1'b0, "Shift Right Arith (Pos)");

        check_op(5'b10000, 8'b1000_0001, 8'd2,  1'b0, "Rotate Right");
        check_op(5'b10001, 8'b1000_0001, 8'd2,  1'b0, "Rotate Left");

        check_op(5'b10010, 8'd45,  8'd80,  1'b0, "Transfer Greater (B > A)");
        check_op(5'b10010, 8'd90,  8'd20,  1'b0, "Transfer Greater (A > B)");
        check_op(5'b10011, 8'hAA,  8'h55,  1'b0, "MUX (Cin = 0 -> A)");
        check_op(5'b10011, 8'hAA,  8'h55,  1'b1, "MUX (Cin = 1 -> B)");
        check_op(5'b10100, 8'hF0,  8'h0F,  1'b0, "Complement (~A LSB, ~B MSB)");
        check_op(5'b10101, 8'd100, 8'd50,  1'b0, "Compare (A > B)");
        check_op(5'b10101, 8'd50,  8'd50,  1'b0, "Compare (A == B)");
        check_op(5'b10101, 8'd20,  8'd50,  1'b0, "Compare (A < B)");
        check_op(5'b10110, 8'b1000_0000, 8'b0000_0011, 1'b0, "Parity (Odd A=1, Even B=1)");
        check_op(5'b10110, 8'b1100_0000, 8'b0000_0001, 1'b0, "Parity (Odd A=0, Even B=0)");

    end

endmodule
