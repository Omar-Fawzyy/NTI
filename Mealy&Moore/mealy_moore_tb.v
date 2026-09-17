module tb_sequence_detectors;

    reg clk;
    reg rst;
    reg in;

    wire out_mealy_ov;
    wire out_mealy_nov;
    wire out_moore_ov;
    wire out_moore_nov;

    mealy_overlapping_110101 u_mealy_ov (
        .clk(clk), .rst(rst), .in(in), .out(out_mealy_ov)
    );

    mealy_non_overlapping_110101 u_mealy_nov (
        .clk(clk), .rst(rst), .in(in), .out(out_mealy_nov)
    );

    moore_overlapping_110101 u_moore_ov (
        .clk(clk), .rst(rst), .in(in), .out(out_moore_ov)
    );

    moore_non_overlapping_110101 u_moore_nov (
        .clk(clk), .rst(rst), .in(in), .out(out_moore_nov)
    );

    always #5 clk = ~clk;

    reg [10:0] test_stream = 11'b11010110101;
    integer i;

    initial begin
        clk = 0;
        rst = 1;
        in  = 0;

        #15 rst = 0;

        for (i = 10; i >= 0; i = i - 1) begin
            @(negedge clk);
            in = test_stream[i];
            
            @(posedge clk);
            #1;
        end

        @(negedge clk);
        in = 0;
        @(posedge clk);
        #1;

        #20;
        $finish;
    end

endmodule
