//Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
//Date        : Fri Dec  1 18:57:19 2017
//Host        : ispc2016 running 64-bit Ubuntu 14.04.5 LTS
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=4,numReposBlks=4,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_board_cnt=4,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (rs232_uart_rxd,
    rs232_uart_txd);
  input rs232_uart_rxd;
  output rs232_uart_txd;

  wire axi_uartlite_0_UART_RxD;
  wire axi_uartlite_0_UART_TxD;
  wire clk_wiz_0_clk_out1;
  wire clk_wiz_0_locked;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [31:0]loopback_top_0_S_AXI_ARADDR;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_ARREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_ARVALID;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [31:0]loopback_top_0_S_AXI_AWADDR;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_AWREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_AWVALID;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_BREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [1:0]loopback_top_0_S_AXI_BRESP;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_BVALID;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [31:0]loopback_top_0_S_AXI_RDATA;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_RREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [1:0]loopback_top_0_S_AXI_RRESP;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_RVALID;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [31:0]loopback_top_0_S_AXI_WDATA;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_WREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [3:0]loopback_top_0_S_AXI_WSTRB;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire loopback_top_0_S_AXI_WVALID;

  assign axi_uartlite_0_UART_RxD = rs232_uart_rxd;
  assign rs232_uart_txd = axi_uartlite_0_UART_TxD;
  design_1_axi_uartlite_0_1 axi_uartlite_0
       (.rx(axi_uartlite_0_UART_RxD),
        .s_axi_aclk(clk_wiz_0_clk_out1),
        .s_axi_araddr(loopback_top_0_S_AXI_ARADDR[3:0]),
        .s_axi_aresetn(clk_wiz_0_locked),
        .s_axi_arready(loopback_top_0_S_AXI_ARREADY),
        .s_axi_arvalid(loopback_top_0_S_AXI_ARVALID),
        .s_axi_awaddr(loopback_top_0_S_AXI_AWADDR[3:0]),
        .s_axi_awready(loopback_top_0_S_AXI_AWREADY),
        .s_axi_awvalid(loopback_top_0_S_AXI_AWVALID),
        .s_axi_bready(loopback_top_0_S_AXI_BREADY),
        .s_axi_bresp(loopback_top_0_S_AXI_BRESP),
        .s_axi_bvalid(loopback_top_0_S_AXI_BVALID),
        .s_axi_rdata(loopback_top_0_S_AXI_RDATA),
        .s_axi_rready(loopback_top_0_S_AXI_RREADY),
        .s_axi_rresp(loopback_top_0_S_AXI_RRESP),
        .s_axi_rvalid(loopback_top_0_S_AXI_RVALID),
        .s_axi_wdata(loopback_top_0_S_AXI_WDATA),
        .s_axi_wready(loopback_top_0_S_AXI_WREADY),
        .s_axi_wstrb(loopback_top_0_S_AXI_WSTRB),
        .s_axi_wvalid(loopback_top_0_S_AXI_WVALID),
        .tx(axi_uartlite_0_UART_TxD));
  design_1_loopback_top_0_0 loopback_top_0
       (.CLK(clk_wiz_0_clk_out1),
        .RST_N(clk_wiz_0_locked),
        .S_AXI_ARADDR(loopback_top_0_S_AXI_ARADDR),
        .S_AXI_ARREADY(loopback_top_0_S_AXI_ARREADY),
        .S_AXI_ARVALID(loopback_top_0_S_AXI_ARVALID),
        .S_AXI_AWADDR(loopback_top_0_S_AXI_AWADDR),
        .S_AXI_AWREADY(loopback_top_0_S_AXI_AWREADY),
        .S_AXI_AWVALID(loopback_top_0_S_AXI_AWVALID),
        .S_AXI_BREADY(loopback_top_0_S_AXI_BREADY),
        .S_AXI_BRESP(loopback_top_0_S_AXI_BRESP),
        .S_AXI_BVALID(loopback_top_0_S_AXI_BVALID),
        .S_AXI_RDATA(loopback_top_0_S_AXI_RDATA),
        .S_AXI_RREADY(loopback_top_0_S_AXI_RREADY),
        .S_AXI_RRESP(loopback_top_0_S_AXI_RRESP),
        .S_AXI_RVALID(loopback_top_0_S_AXI_RVALID),
        .S_AXI_WDATA(loopback_top_0_S_AXI_WDATA),
        .S_AXI_WREADY(loopback_top_0_S_AXI_WREADY),
        .S_AXI_WSTRB(loopback_top_0_S_AXI_WSTRB),
        .S_AXI_WVALID(loopback_top_0_S_AXI_WVALID));
  design_1_sim_clk_gen_0_0 sim_clk_gen_0
       (.clk(clk_wiz_0_clk_out1),
        .sync_rst(clk_wiz_0_locked));
  design_1_system_ila_0 system_ila
       (.SLOT_0_AXI_araddr(loopback_top_0_S_AXI_ARADDR),
        .SLOT_0_AXI_arready(loopback_top_0_S_AXI_ARREADY),
        .SLOT_0_AXI_arvalid(loopback_top_0_S_AXI_ARVALID),
        .SLOT_0_AXI_awaddr(loopback_top_0_S_AXI_AWADDR),
        .SLOT_0_AXI_awready(loopback_top_0_S_AXI_AWREADY),
        .SLOT_0_AXI_awvalid(loopback_top_0_S_AXI_AWVALID),
        .SLOT_0_AXI_bready(loopback_top_0_S_AXI_BREADY),
        .SLOT_0_AXI_bresp(loopback_top_0_S_AXI_BRESP),
        .SLOT_0_AXI_bvalid(loopback_top_0_S_AXI_BVALID),
        .SLOT_0_AXI_rdata(loopback_top_0_S_AXI_RDATA),
        .SLOT_0_AXI_rready(loopback_top_0_S_AXI_RREADY),
        .SLOT_0_AXI_rresp(loopback_top_0_S_AXI_RRESP),
        .SLOT_0_AXI_rvalid(loopback_top_0_S_AXI_RVALID),
        .SLOT_0_AXI_wdata(loopback_top_0_S_AXI_WDATA),
        .SLOT_0_AXI_wready(loopback_top_0_S_AXI_WREADY),
        .SLOT_0_AXI_wvalid(loopback_top_0_S_AXI_WVALID),
        .clk(clk_wiz_0_clk_out1));
endmodule