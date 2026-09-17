module system_top #(
    parameter DATA_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst,
    
    input  wire [DATA_WIDTH-1:0] cpu_in,
    input  wire [DATA_WIDTH-1:0] mem_in,
    input  wire [DATA_WIDTH-1:0] uart_rx_in,
    input  wire [DATA_WIDTH-1:0] int_in,
    
    input  wire [1:0]            route_sel,
    
    output wire [DATA_WIDTH-1:0] cpu_out,
    output wire [DATA_WIDTH-1:0] mem_out,
    output wire [DATA_WIDTH-1:0] int_out,
    
    output wire                  uart_tx_serial,
    input  wire                  uart_rx_serial
);

    wire [DATA_WIDTH-1:0] router_uart_tx;

    router #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_router (
        .cpu_in      (cpu_in),
        .mem_in      (mem_in),
        .uart_rx     (uart_rx_in),
        .int_in      (int_in),
        .route_sel   (route_sel),
        
        .cpu_out     (cpu_out),
        .mem_out     (mem_out),
        .uart_tx     (router_uart_tx),
        .int_out     (int_out)
    );

    uart_module #(
        .DATA_WIDTH(DATA_WIDTH)
    ) u_uart (
        .clk         (clk),
        .rst         (rst),
        .tx_data_in  (router_uart_tx),
        .tx_serial   (uart_tx_serial),
        .rx_serial   (uart_rx_serial)
    );

endmodule


module router #(
    parameter DATA_WIDTH = 8
)(
    input  wire [DATA_WIDTH-1:0] cpu_in,
    input  wire [DATA_WIDTH-1:0] mem_in,
    input  wire [DATA_WIDTH-1:0] uart_rx,
    input  wire [DATA_WIDTH-1:0] int_in,
    
    input  wire [1:0]            route_sel,
    
    output reg  [DATA_WIDTH-1:0] cpu_out,
    output reg  [DATA_WIDTH-1:0] mem_out,
    output reg  [DATA_WIDTH-1:0] uart_tx,
    output reg  [DATA_WIDTH-1:0] int_out
);

    always @(*) begin
        cpu_out = {DATA_WIDTH{1'b0}};
        mem_out = {DATA_WIDTH{1'b0}};
        uart_tx = {DATA_WIDTH{1'b0}};
        int_out = {DATA_WIDTH{1'b0}};

        case (route_sel)
            2'b00: cpu_out = cpu_in;
            2'b01: mem_out = mem_in;
            2'b10: uart_tx = uart_rx;
            2'b11: int_out = int_in;
            default: uart_tx = uart_rx;
        endcase
    end

endmodule


module uart_module #(
    parameter DATA_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst,
    
    input  wire [DATA_WIDTH-1:0] tx_data_in,
    output wire                  tx_serial,
    
    input  wire                  rx_serial,
    output reg  [DATA_WIDTH-1:0] rx_data_out
);

endmodule
