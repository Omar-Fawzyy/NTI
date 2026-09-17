module seven_seg (
    input  wire [3:0] in_bin,
    output reg  [6:0] out_seg
);

    always @(*) begin
        case (in_bin)
            4'h0:    out_seg = 7'b1000000;
            4'h1:    out_seg = 7'b1111001;
            4'h2:    out_seg = 7'b0100100;
            4'h3:    out_seg = 7'b0110000;
            4'h4:    out_seg = 7'b0011001;
            4'h5:    out_seg = 7'b0010010;
            4'h6:    out_seg = 7'b0000010;
            4'h7:    out_seg = 7'b1111000;
            4'h8:    out_seg = 7'b0000000;
            4'h9:    out_seg = 7'b0010000;
            4'hA:    out_seg = 7'b0001000;
            4'hB:    out_seg = 7'b0000011;
            4'hC:    out_seg = 7'b1000110;
            4'hD:    out_seg = 7'b0100001;
            4'hE:    out_seg = 7'b0000110;
            4'hF:    out_seg = 7'b0001110;
            default: out_seg = 7'b1111111;
        endcase
    end

endmodule
