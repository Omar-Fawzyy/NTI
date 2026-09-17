module Dec_2x4 #(
    parameter N = 2           
)(
    input                       en,
    input       [N-1:0]         in,
    output reg  [(1<<N)-1:0]    out
);

    always @(*) begin
        if (en)
            out = (1'b1 << in);
        else
            out = {(1<<N){1'b0}};  
    end
 
endmodule
