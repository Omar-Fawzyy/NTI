module ENC_DEC_tb;

    parameter N_out = 2;
    parameter N_IN  = (1 << N_out);

    reg  [N_IN-1:0]  tb_in;
    wire [N_out-1:0] enc_out;
    wire             enc_en;
    wire [N_IN-1:0]  dec_out;

    integer errors;
    integer i;

    generic_encoder #(
        .N_out(N_out),
        .N_in(N_IN)
    ) uut_encoder (
        .in  (tb_in),
        .out (enc_out),
        .en  (enc_en)
    );

    generic_decoder #(
        .N   (N_out)
    ) uut_decoder (
        .en  (enc_en),
        .in  (enc_out),
        .out (dec_out)
    );

    initial begin
        errors = 0;

        tb_in = {N_IN{1'b0}};
        #10;
        if (enc_en !== 1'b0 || dec_out !== {N_IN{1'b0}})
            errors = errors + 1;

        for (i = 0; i < N_IN; i = i + 1) begin
            tb_in = (1 << i);
            #10;
            if (enc_en !== 1'b1 || enc_out !== i[N_out-1:0] || dec_out !== tb_in)
                errors = errors + 1;
        end

        tb_in = 4'b1010;
        #10;
        if (enc_out !== 2'b11 || dec_out !== 4'b1000)
            errors = errors + 1;

        tb_in = 4'b1111;
        #10;
        if (enc_out !== 2'b11 || dec_out !== 4'b1000)
            errors = errors + 1;

        #10;
    end

endmodule
