module alu_8bit (
    input  wire [7:0]  A,
    input  wire [7:0]  B,
    input  wire        Cin,
    input  wire [4:0]  Control,
    output reg  [15:0] Out
);

    always @(*) begin
        case (Control)
            5'b00000: Out = {8'b0, A} + {8'b0, B};
            5'b00001: Out = {8'b0, A} + {8'b0, B} + 16'd1;
            5'b00010: Out = {8'b0, A} + {8'b0, ~B} + 16'd1;
            5'b00011: Out = {8'b0, A} + {8'b0, ~B};
            5'b00100: Out = {8'b0, A} + 16'd1;
            5'b00101: Out = {8'b0, A} - 16'd1;
            5'b00110: Out = (A * B) + 16'd1;

            5'b00111: Out = {8'b0, (A & B)};
            5'b01000: Out = {8'b0, (A | B)};
            5'b01001: Out = {8'b0, (A ^ B)};
            5'b01010: Out = {8'b0, (~A)};
            5'b01011: Out = {8'b0, ~(A & B)};

            5'b01100: begin
                if (B >= 8) Out = 16'b0;
                else begin
                    case (B[2:0])
                        3'd0: Out = {8'b0, A};
                        3'd1: Out = {8'b0, A[6:0], 1'b0};
                        3'd2: Out = {8'b0, A[5:0], 2'b00};
                        3'd3: Out = {8'b0, A[4:0], 3'b000};
                        3'd4: Out = {8'b0, A[3:0], 4'b0000};
                        3'd5: Out = {8'b0, A[2:0], 5'b00000};
                        3'd6: Out = {8'b0, A[1:0], 6'b000000};
                        3'd7: Out = {8'b0, A[0],   7'b0000000};
                    endcase
                end
            end

            5'b01101: Out = {8'b0, (A >> B)};
            5'b01110: Out = {8'b0, (A <<< B)};

            5'b01111: begin
                if (B >= 8) Out = {8'b0, {8{A[7]}}};
                else begin
                    case (B[2:0])
                        3'd0: Out = {8'b0, A};
                        3'd1: Out = {8'b0, A[7], A[7:1]};
                        3'd2: Out = {8'b0, {2{A[7]}}, A[7:2]};
                        3'd3: Out = {8'b0, {3{A[7]}}, A[7:3]};
                        3'd4: Out = {8'b0, {4{A[7]}}, A[7:4]};
                        3'd5: Out = {8'b0, {5{A[7]}}, A[7:5]};
                        3'd6: Out = {8'b0, {6{A[7]}}, A[7:6]};
                        3'd7: Out = {8'b0, {7{A[7]}}, A[7]};
                    endcase
                end
            end

            5'b10000: begin
                case (B[2:0])
                    3'd0: Out = {8'b0, A};
                    3'd1: Out = {8'b0, A[0],   A[7:1]};
                    3'd2: Out = {8'b0, A[1:0], A[7:2]};
                    3'd3: Out = {8'b0, A[2:0], A[7:3]};
                    3'd4: Out = {8'b0, A[3:0], A[7:4]};
                    3'd5: Out = {8'b0, A[4:0], A[7:5]};
                    3'd6: Out = {8'b0, A[5:0], A[7:6]};
                    3'd7: Out = {8'b0, A[6:0], A[7]};
                endcase
            end

            5'b10001: begin
                case (B[2:0])
                    3'd0: Out = {8'b0, A};
                    3'd1: Out = {8'b0, A[6:0], A[7]};
                    3'd2: Out = {8'b0, A[5:0], A[7:6]};
                    3'd3: Out = {8'b0, A[4:0], A[7:5]};
                    3'd4: Out = {8'b0, A[3:0], A[7:4]};
                    3'd5: Out = {8'b0, A[2:0], A[7:3]};
                    3'd6: Out = {8'b0, A[1:0], A[7:2]};
                    3'd7: Out = {8'b0, A[0],   A[7:1]};
                endcase
            end

            5'b10010: Out = (A >= B) ? {8'b0, A} : {8'b0, B};
            5'b10011: Out = (Cin == 1'b0) ? {8'b0, A} : {8'b0, B};
            5'b10100: Out = {~B, ~A};
            5'b10101: Out = {10'b0, (A >= B), (A > B), (A == B), (A <= B), (A < B), (A != B)};
            5'b10110: Out = {14'b0, ~^B, ^A};

            default:  Out = 16'b0;
        endcase
    end

endmodule
