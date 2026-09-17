module tb_Data_Scrambler;

    reg  [7:0] data_in;
    reg  [1:0] scramble_key;
    reg  [1:0] op_mode;
    reg        sleep_mode;
    wire [7:0] data_out;
    wire       parity_err;
    wire       is_zero;

    Data_Scrambler uut (
        .data_in(data_in),
        .scramble_key(scramble_key),
        .op_mode(op_mode),
        .sleep_mode(sleep_mode),
        .data_out(data_out),
        .parity_err(parity_err),
        .is_zero(is_zero)
    );

    initial begin
        sleep_mode   = 1'b0;
        op_mode      = 2'b00;
        scramble_key = 2'b00;
        data_in      = 8'h00;
        #20;

        op_mode = 2'b00;
        data_in = 8'hA5;
        #20;
        data_in = 8'h00;
        #20;

        op_mode      = 2'b01;
        scramble_key = 2'b10;
        data_in      = 8'hFF;
        #20;
        scramble_key = 2'b01;
        data_in      = 8'hAA;
        #20;

        op_mode = 2'b10;
        data_in = 8'b01001000;
        #20;
        data_in = 8'b10001000;
        #20;
        data_in = 8'b10000000;
        #20;

        op_mode = 2'b11;
        data_in = 8'hA3;       
        #20;
        data_in = 8'hF0;     
        #20;

        op_mode      = 2'b01;
        scramble_key = 2'b11;
        data_in      = 8'hFF;
        sleep_mode   = 1'b1; 
        #20;
        op_mode      = 2'b10;
        data_in      = 8'h88;
        sleep_mode   = 1'b1;
        #20;
        sleep_mode   = 1'b0;
        #20;

        $finish;
    end

endmodule
