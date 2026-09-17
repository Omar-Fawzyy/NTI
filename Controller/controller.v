module control (
    output reg        sel,
    output reg        rd,
    output reg        ld_ir,
    output reg        halt,
    output reg        inc_pc,
    output reg        ld_ac,
    output reg        ld_pc,
    output reg        wr,
    output reg        data_e,
    input      [2:0]  opcode,
    input      [2:0]  phase,
    input             zero
);

    localparam INST_ADDR  = 3'b000;
    localparam INST_FETCH = 3'b001;
    localparam INST_LOAD  = 3'b010;
    localparam IDLE       = 3'b011;
    localparam OP_ADDR    = 3'b100;
    localparam OP_FETCH   = 3'b101;
    localparam ALU_OP     = 3'b110;
    localparam STORE      = 3'b111;

    reg HLT, SKZ, ADD, AND, XOR, LDA, STO, JMP;
    reg HALT, ALUOP;

    always @(*) begin
        HLT   = (opcode == 3'b000);
        SKZ   = (opcode == 3'b001);
        ADD   = (opcode == 3'b010);
        AND   = (opcode == 3'b011);
        XOR   = (opcode == 3'b100);
        LDA   = (opcode == 3'b101);
        STO   = (opcode == 3'b110);
        JMP   = (opcode == 3'b111);

        HALT  = HLT;
        ALUOP = ADD || AND || XOR || LDA;

        sel    = 1'b0;
        rd     = 1'b0;
        ld_ir  = 1'b0;
        halt   = 1'b0;
        inc_pc = 1'b0;
        ld_ac  = 1'b0;
        ld_pc  = 1'b0;
        wr     = 1'b0;
        data_e = 1'b0;

        case (phase)
            INST_ADDR: begin
                sel = 1'b1;
            end

            INST_FETCH: begin
                sel = 1'b1;
                rd  = 1'b1;
            end

            INST_LOAD: begin
                sel   = 1'b1;
                rd    = 1'b1;
                ld_ir = 1'b1;
            end

            IDLE: begin
                sel   = 1'b1;
                rd    = 1'b1;
                ld_ir = 1'b1;
            end

            OP_ADDR: begin
                halt = HALT;
            end

            OP_FETCH: begin
                rd = ALUOP;
            end

            ALU_OP: begin
                rd     = ALUOP;
                inc_pc = SKZ && zero;
                ld_pc  = JMP;
                data_e = STO;
            end

            STORE: begin
                ld_ac  = ALUOP;
                wr     = STO;
                data_e = STO;
            end

            default: begin
                sel    = 1'b0;
                rd     = 1'b0;
                ld_ir  = 1'b0;
                halt   = 1'b0;
                inc_pc = 1'b0;
                ld_ac  = 1'b0;
                ld_pc  = 1'b0;
                wr     = 1'b0;
                data_e = 1'b0;
            end
        endcase
    end

endmodule
