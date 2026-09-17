module multiplexor #(
    parameter size = 5
)(
    output  [size-1:0] mux_out,
    input   [size-1:0] in0, in1,
    input              sel
);

    assign mux_out = sel ? in1 : in0;

endmodule
