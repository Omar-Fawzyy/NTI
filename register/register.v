module register #(

   parameter size=8
)(

   input       [size-1:0]  data_in,
   input                   clk,
   input                   rst,
   input                   load,
   output reg  [size-1:0]  data_out
);

  always@(posedge clk) begin
      if (rst) begin
            data_out <= {size{1'b0}};
      end else if (load) begin
            data_out <= data_in;
      end
  end


endmodule