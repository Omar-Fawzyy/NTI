module system_top_tb;

    parameter DATA_WIDTH = 8;

    reg                  clk;
    reg                  rst;
    reg [DATA_WIDTH-1:0] cpu_in;
    reg [DATA_WIDTH-1:0] mem_in;
    reg [DATA_WIDTH-1:0] uart_rx_in;
    reg [DATA_WIDTH-1:0] int_in;
    reg [1:0]            route_sel;
    reg                  uart_rx_serial;

    wire [DATA_WIDTH-1:0] cpu_out;
    wire [DATA_WIDTH-1:0] mem_out;
    wire [DATA_WIDTH-1:0] int_out;
    wire                  uart_tx_serial;

    system_top #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .clk            (clk),
        .rst            (rst),
        .cpu_in         (cpu_in),
        .mem_in         (mem_in),
        .uart_rx_in     (uart_rx_in),
        .int_in         (int_in),
        .route_sel      (route_sel),
        .cpu_out        (cpu_out),
        .mem_out        (mem_out),
        .int_out        (int_out),
        .uart_tx_serial (uart_tx_serial),
        .uart_rx_serial (uart_rx_serial)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        cpu_in = 8'h00;
        mem_in = 8'h00;
        uart_rx_in = 8'h00;
        int_in = 8'h00;
        route_sel = 2'b00;
        uart_rx_serial = 1'b1;

        #20 rst = 0;

        cpu_in     = 8'hAA;
        mem_in     = 8'hBB;
        uart_rx_in = 8'hCC;
        int_in     = 8'hDD;

        route_sel = 2'b00; #10;
        route_sel = 2'b01; #10;
        route_sel = 2'b10; #10;
        route_sel = 2'b11; #10;

        #20;
        $finish;
    end

    initial begin
        $monitor("Time=%0t | Sel=%b | CPU_out=%h | MEM_out=%h | INT_out=%h | Router_UART_out=%h", 
                 $time, route_sel, cpu_out, mem_out, int_out, uut.router_uart_tx);
    end

endmodule
