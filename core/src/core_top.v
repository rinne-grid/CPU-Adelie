module core_top
  (
    input RST_N,
    input CLK,
    // Memory input and output

    input [31:0] I_MEM_IN,
    output [31:0] I_MEM_ADDR,
    // メモリからのデータをMEM_INで受け取り、欲しいアドレスをMEM_ADDRで出力
    // する
    input [31:0] MEM_IN,
    output [31:0] MEM_DATA,
    output [31:0] MEM_ADDR,
    output MEM_WE,

    // 浮動小数点
    // ADD/SUB
    output [31:0] ADDSUB_A_TDATA,
    input ADDSUB_A_TREADY,
    output ADDSUB_A_TVALID,
    output [31:0] ADDSUB_B_TDATA,
    input ADDSUB_B_TREADY,
    output ADDSUB_B_TVALID,
    output [7:0] ADDSUB_OP_TDATA,
    input ADDSUB_OP_TREADY,
    output ADDSUB_OP_TVALID,
    input [31:0] ADDSUB_R_TDATA,
    output ADDSUB_R_TREADY,
    input ADDSUB_R_TVALID,

    // 浮動小数点
    // MUL 
    output [31:0] MUL_A_TDATA,
    input MUL_A_TREADY,
    output MUL_A_TVALID,
    output [31:0] MUL_B_TDATA,
    input MUL_B_TREADY,
    output MUL_B_TVALID,
    input [31:0] MUL_R_TDATA,
    output MUL_R_TREADY,
    input MUL_R_TVALID,

    // 浮動小数点
    // DIV
    output [31:0] DIV_A_TDATA,
    input DIV_A_TREADY,
    output DIV_A_TVALID,
    output [31:0] DIV_B_TDATA,
    input DIV_B_TREADY,
    output DIV_B_TVALID,
    input [31:0] DIV_R_TDATA,
    output DIV_R_TREADY,
    input DIV_R_TVALID,

    // 浮動小数点
    // COMP
    output [31:0] COMP_A_TDATA,
    input COMP_A_TREADY,
    output COMP_A_TVALID,
    output [31:0] COMP_B_TDATA,
    input COMP_B_TREADY,
    output COMP_B_TVALID,
    output [7:0] COMP_OP_TDATA,
    input COMP_OP_TREADY,
    output COMP_OP_TVALID,
    input [31:0] COMP_R_TDATA,
    output COMP_R_TREADY,
    input COMP_R_TVALID,

    // In/Out
    output [3:0] S_AXI_AWADDR,
    output S_AXI_AWVALID,
    input S_AXI_AWREADY,

    output [31:0] S_AXI_WDATA,
    output [3:0] S_AXI_WSTB,
    output S_AXI_WVALID,
    input S_AXI_WREADY,

    input [1:0] S_AXI_BRESP,
    input S_AXI_BVALID,
    output S_AXI_BREADY,

    output [3:0] S_AXI_ARADDR,
    output S_AXI_ARVALID,
    input S_AXI_ARREADY,

    input [31:0] S_AXI_RDATA,
    input [1:0] S_AXI_RRESP,
    input S_AXI_RVALID,
    output S_AXI_RREADY

  );

  // PC
  wire [31:0] pc;
  wire [4:0] rd_num, rs1_num, rs2_num;
  wire [31:0] rs1, rs2, imm;

  wire [31:0] alu_result;
  
  wire i_lui, i_auipc, i_jal, i_jalr, i_beq, i_bne,
       i_blt, i_bge, i_bltu, i_bgeu, i_lb, i_lh, i_lw, i_lbu, i_lhu, i_sb, i_sh,
       i_sw, i_addi, i_slti, i_sltiu, i_xori, i_ori, i_andi, i_slli, i_srli, i_srai,
       i_add, i_sub, i_sll, i_slt, i_sltu, i_xor, i_srl, i_sra, i_or, i_and;
  wire i_flw, i_fsw, i_fadds, i_fsubs, i_fmuls, i_fdivs, i_feqs, i_flts, i_fles;
  wire i_in, i_out;
  wire n_inst;

  reg [3:0] s_axi_awaddr, s_axi_araddr;
  reg [31:0] s_axi_wdata, s_axi_rdata;
  reg [1:0] s_axi_bresp, s_axi_rresp;
  reg s_axi_awvalid, s_axi_awready, s_axi_wvalid, s_axi_wready, s_axi_bvalid, s_axi_bready, s_axi_arvalid, s_axi_arready, s_axi_rvalid, s_axi_rready;

  // ADDSUB
  reg [31:0] addsub_a_tdata, addsub_b_tdata,addsub_r_tdata;
  reg [7:0] addsub_op_tdata;
  reg addsub_a_tvalid, addsub_b_tvalid, addsub_op_tvalid, addsub_r_tready;
  assign ADDSUB_A_TDATA = addsub_a_tdata;
  assign ADDSUB_B_TDATA = addsub_b_tdata;
  assign ADDSUB_A_TVALID = addsub_a_tvalid;
  assign ADDSUB_B_TVALID = addsub_b_tvalid;
  assign ADDSUB_OP_TDATA = addsub_op_tdata;
  assign ADDSUB_OP_TVALID = addsub_op_tvalid;
  assign ADDSUB_R_TREADY = addsub_r_tready;
  assign ADDSUB_R_TDATA = addsub_r_tdata;

  // MUL
  reg [31:0] mul_a_tdata, mul_b_tdata,mul_r_tdata;
  reg mul_a_tvalid, mul_b_tvalid, mul_r_tready;
  assign MUL_A_TDATA = mul_a_tdata;
  assign MUL_B_TDATA = mul_b_tdata;
  assign MUL_A_TVALID = mul_a_tvalid;
  assign MUL_B_TVALID = mul_b_tvalid;
  assign MUL_R_TREADY = mul_r_tready;
  assign MUL_R_TDATA = mul_r_tdata;

  // DIV
  reg [31:0] div_a_tdata, div_b_tdata,div_r_tdata;
  reg div_a_tvalid, div_b_tvalid, div_r_tready;
  assign DIV_A_TDATA = div_a_tdata;
  assign DIV_B_TDATA = div_b_tdata;
  assign DIV_A_TVALID = div_a_tvalid;
  assign DIV_B_TVALID = div_b_tvalid;
  assign DIV_R_TREADY = div_r_tready;
  assign DIV_R_TDATA = div_r_tdata;

  // COMP
  reg [31:0] comp_a_tdata, comp_b_tdata,comp_r_tdata;
  reg [7:0] comp_op_tdata;
  reg comp_a_tvalid, comp_b_tvalid, comp_op_tvalid, comp_r_tready;
  assign COMP_A_TDATA = comp_a_tdata;
  assign COMP_B_TDATA = comp_b_tdata;
  assign COMP_A_TVALID = comp_a_tvalid;
  assign COMP_B_TVALID = comp_b_tvalid;
  assign COMP_OP_TDATA = comp_op_tdata;
  assign COMP_OP_TVALID = comp_op_tvalid;
  assign COMP_R_TREADY = comp_r_tready;
  assign COMP_R_TDATA = comp_r_tdata;

  reg stole;

  // 乗除算はまだ

  assign r0 = 32'b0;

  // CPU state
  reg [6:0] cpu_state;
  localparam IDLE = 7'b0000001;
  localparam FETCH = 7'b0000010;
  localparam DECODE = 7'b0000100;
  localparam EXECUTE = 7'b0001000;
  localparam MEMORY = 7'b0100000;
  localparam WRITEBACK = 7'b1000000;

  always @(posedge CLK) begin
    if(!RST_N) begin
      cpu_state <= IDLE;
    end else begin
      if (stole) begin
        cpu_state <= cpu_state;
      end else begin
        case(cpu_state)
          IDLE:
          begin
            cpu_state <= FETCH;
          end
          FETCH:
          begin
            cpu_state <= DECODE;
          end
          DECODE:
          begin
            cpu_state <= EXECUTE;
          end
          EXECUTE:
          begin
            cpu_state <= MEMORY;
          end
          MEMORY:
          begin
            cpu_state <= WRITEBACK;
          end
          WRITEBACK:
          begin
            cpu_state <= FETCH;
          end
        endcase
    end
    end
  end

  // それぞれの段階ごとのアサインをする
  // 1. 命令フェッチ Instruction Fetch
  
  assign I_MEM_ADDR = (pc >> 2);

  // 2. 命令デコード
  
  core_decode u_core_decode
  (
    .RST_N (RST_N),
    .CLK (CLK),

    .INST (I_MEM_IN),

    .RD_NUM (rd_num),
    .RS1_NUM (rs1_num),
    .RS2_NUM (rs2_num),

    .IMM (imm),

    .I_ADDI (i_addi),
    .I_SLTI (i_slti),
    .I_SLTIU (i_sltiu),
    .I_XORI (i_xori),
    .I_ORI (i_ori),
    .I_ANDI (i_andi),
    .I_SLLI (i_slli),
    .I_SRLI (i_srli),
    .I_SRAI (i_srai),
    .I_ADD (i_add),
    .I_SUB (i_sub),
    .I_SLL (i_sll),
    .I_SLT (i_slt),
    .I_SLTU (i_sltu),
    .I_XOR (i_xor),
    .I_SRL (i_srl),
    .I_SRA (i_sra),
    .I_OR (i_or),
    .I_AND (i_and),

    .I_BEQ (i_beq),
    .I_BNE (i_bne),
    .I_BLT (i_blt),
    .I_BGE (i_bge),
    .I_BLTU (i_bltu),
    .I_BGEU (i_bgeu),

    .I_LB (i_lb),
    .I_LH (i_lh),
    .I_LW (i_lw),
    .I_LBU (i_lbu),
    .I_LHU (i_lhu),
    .I_SB (i_sb),
    .I_SH (i_sh),
    .I_SW (i_sw),

    .I_JALR (i_jalr),
    .I_JAL (i_jal),
    .I_AUIPC (i_auipc),
    .I_LUI (i_lui),

    .I_FLW (i_flw),
    .I_FSW (i_fsw),
    .I_FADDS (i_fadds),
    .I_FSUBS (i_fsubs),
    .I_FMULS (i_fmuls),
    .I_FDIVS (i_fdivs),
    .I_FEQS (i_feqs),
    .I_FLTS (i_flts),
    .I_FLES (i_fles),

    .I_IN (i_in),
    .I_OUT (i_out),

    .N_INST (n_inst)

  );
  
  // 3. 実行
  
  core_alu u_core_alu
  (
    .RST_N (RST_N),
    .CLK (CLK),

    .I_ADDI (i_addi),
    .I_SLTI (i_slti),
    .I_SLTIU (i_sltiu),
    .I_XORI (i_xori),
    .I_ORI (i_ori),
    .I_ANDI (i_andi),
    .I_SLLI (i_slli),
    .I_SRLI (i_srli),
    .I_SRAI (i_srai),
    .I_ADD (i_add),
    .I_SUB (i_sub),
    .I_SLL (i_sll),
    .I_SLT (i_slt),
    .I_SLTU (i_sltu),
    .I_XOR (i_xor),
    .I_SRL (i_srl),
    .I_SRA (i_sra),
    .I_OR (i_or),
    .I_AND (i_and),

    .I_BEQ (i_beq),
    .I_BNE (i_bne),
    .I_BLT (i_blt),
    .I_BGE (i_bge),
    .I_BLTU (i_bltu),
    .I_BGEU (i_bgeu),

    .I_LB (i_lb),
    .I_LH (i_lh),
    .I_LW (i_lw),
    .I_LBU (i_lbu),
    .I_LHU (i_lhu),
    .I_SB (i_sb),
    .I_SH (i_sh),
    .I_SW (i_sw),

    .I_FLW (i_flw),
    .I_FSW (i_fsw),

    .RS1 (rs1),
    .RS2 (rs2),
    .IMM (imm),
    
    .RESULT (alu_result)

  );

  // 浮動小数点実行
  // ADD/SUB
  always @(posedge CLK) begin
    if (i_fadds | i_fsubs) begin
      addsub_a_tdata <= rs1;
      addsub_a_tvalid <= 1'b1;
      addsub_b_tdata <= rs2;
      addsub_b_tvalid <= 1'b1;
      addsub_op_tdata <= i_fsubs ? 6'b000001 : 6'b000000;
      addsub_op_tvalid <= 1'b1;
      addsub_r_tready <= 1'b1;
      stole <= ADDSUB_R_TVALID ? 0 : 1;
    end else begin
      addsub_a_tdata <= 0;
      addsub_a_tvalid <= 0;
      addsub_b_tdata <= 0;
      addsub_b_tvalid <= 0;
      addsub_op_tdata <= 0;
      addsub_op_tvalid <= 0;
      addsub_r_tready <= 0;
    end
  end

  // 浮動小数点実行
  // MULS
  always @(posedge CLK) begin
    if (i_fmuls) begin
      mul_a_tdata <= rs1;
      mul_a_tvalid <= 1'b1;
      mul_b_tdata <= rs2;
      mul_b_tvalid <= 1'b1;
      mul_r_tready <= 1'b1;
      stole <= MUL_R_TVALID ? 0 : 1;
    end else begin
      mul_a_tdata <= 0;
      mul_a_tvalid <= 0;
      mul_b_tdata <= 0;
      mul_b_tvalid <= 0;
      mul_r_tready <= 0;
    end
  end

  // 浮動小数点実行
  // DIVS
  always @(posedge CLK) begin
    if (i_fdivs) begin
      div_a_tdata <= rs1;
      div_a_tvalid <= 1'b1;
      div_b_tdata <= rs2;
      div_b_tvalid <= 1'b1;
      div_r_tready <= 1'b1;
      stole <= DIV_R_TVALID ? 0 : 1;
    end else begin
      div_a_tdata <= 0;
      div_a_tvalid <= 0;
      div_b_tdata <= 0;
      div_b_tvalid <= 0;
      div_r_tready <= 0;
    end
  end

  // 浮動小数点実行
  // COMP
  always @(posedge CLK) begin
    if (i_feqs | i_flts | i_fles) begin
      comp_a_tdata <= rs1;
      comp_a_tvalid <= 1'b1;
      comp_b_tdata <= rs2;
      comp_b_tvalid <= 1'b1;
      comp_op_tdata <= i_feqs ? 6'b010100 :
                       i_flts ? 6'b001100:
                       6'b011100;
      comp_op_tvalid <= 1'b1;
      comp_r_tready <= 1'b1;
      stole <= COMP_R_TVALID ? 0 : 1;
    end else begin
      comp_a_tdata <= 0;
      comp_a_tvalid <= 0;
      comp_b_tdata <= 0;
      comp_b_tvalid <= 0;
      comp_op_tdata <= 0;
      comp_op_tvalid <= 0;
      comp_r_tready <= 0;
    end
  end

  // in/out実行
  // inならrdに書き込むだけ
  // ineをほげする
  // outならr1からoutする
  always @(posedge CLK) begin
    if () begin
    end else begin
    end
  end

  // PC
  reg [31:0] pc_add_imm, pc_add_4, pc_jalr, pc_before;
  always @(posedge CLK) begin
    pc_add_imm <= pc_before + imm; // AUIPC, BRANCH, JAL
    pc_jalr <= rs1 + imm;
    pc_add_4 <= pc_before + 4;
    pc_before <= pc;
  end
  
  // メモリアクセスの前に実行と切り分ける

  wire [4:0] wr_addr;
  wire  wr_we;
  wire [31:0] wr_data;

  wire wr_pc_we;
  wire [31:0] wr_pc;

  // 4. メモリアクセス

  assign MEM_ADDR = alu_result;
  assign MEM_DATA = (i_sb) ? {4{rs2[7:0]}}:
                   (i_sh) ? {2{rs2[15:0]}}:
                   (i_sw) ? {rs2}:
                   32'd0;
  assign MEM_WE = (i_sb | i_sh | i_sw) && (cpu_state == MEMORY);
 
  // 5. 書き戻し
  

  // レジスタ

  assign wr_pc_we = (cpu_state == MEMORY);
  assign wr_pc = (((i_beq | i_bne | i_blt | i_bge | i_bltu | i_bgeu) & (alu_result == 32'd1)) | i_jal) ? pc_add_imm:
                 (i_jalr) ? pc_jalr:
                 pc_add_4;
  assign wr_we = (cpu_state == WRITEBACK);
  assign wr_data = (i_lui) ? imm:
                   (i_lw | i_lh | i_lb | i_lbu | i_lhu) ? MEM_IN:
                   (i_auipc) ? pc_add_imm:
                   (i_jal | i_jalr) ? pc_add_4:
                   (i_fadds | i_fsubs) ? ADDSUB_R_TDATA:
                   (i_fmuls) ? MUL_R_TDATA:
                   (i_fdivs) ? DIV_R_TDATA:
                   (i_feqs | i_flts | i_fles) ? COMP_R_TDATA:
                   (i_in) ? S_AXI_RDATA:
                     alu_result;
  assign wr_addr = rd_num;

  core_reg u_core_reg
  (
    .RST_N (RST_N),
    .CLK (CLK),

    .WADDR (wr_addr),
    .WE (wr_we),
    .WDATA (wr_data),
    .INE (ine),
    .INDATA (S_AXI_RDATA),

    .RS1ADDR (rs1_num),
    .RS1 (rs1),
    .RS2ADDR (rs2_num),
    .RS2 (rs2),

    .PC_WE (wr_pc_we),
    .PC_WDATA (wr_pc),
    .PC (pc)
  );

endmodule
