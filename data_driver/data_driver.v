module driver #(

  parameter width = 8
)(

  input   [width-1:0] data_in,
  input               data_en,
  output  [width-1:0] data_out
);

  assign data_out = data_en ? data_in : {width{1'bz}};

endmodule