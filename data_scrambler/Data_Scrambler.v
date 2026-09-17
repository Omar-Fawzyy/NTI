module Data_Scrambler (
    input  wire [7:0] data_in,
    input  wire [1:0] scramble_key,
    input  wire [1:0] op_mode,
    input  wire       sleep_mode,
    output reg  [7:0] data_out,
    output wire       parity_err,
    output wire       is_zero
);

    always @(*) begin
        if (sleep_mode) begin
            data_out = 8'b00000000;
        end else begin
            case (op_mode)
                2'b00: data_out = data_in;
                2'b01: data_out = data_in ^ {4{scramble_key}};
                2'b10: data_out = $signed(data_in) >>> 2;
                2'b11: data_out = {data_in[3:0], data_in[7:4]};
                default: data_out = 8'b00000000;
            endcase
        end
    end

    assign parity_err = sleep_mode ? 1'b0 : ~^data_out;
    assign is_zero    = ~|data_out;

endmodule
