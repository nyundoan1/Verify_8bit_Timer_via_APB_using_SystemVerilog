covergroup TIMER_GROUP(ref packet pkt);

  apb_address: coverpoint pkt.addr {
    bins TCR_addr = {8'h00};   // Timer Control Register
    bins TSR_addr = {8'h01};   // Timer Status Register
    bins TDR_addr = {8'h02};   // Timer Data Register
    bins TIE_addr = {8'h03};   // Timer Interrupt Enable
    ignore_bins reserved_addr = {[8'h04:8'hFF]};
  }

  apb_transfer: coverpoint pkt.transfer {
    bins WRITE = {packet::WRITE};
    bins READ  = {packet::READ};
  }

  apb_data: coverpoint pkt.data {
    // General ranges
    bins low_range  = {[8'h00:8'h3F]};
    bins mid_range  = {[8'h40:8'hBF]};
    bins high_range = {[8'hC0:8'hFF]};

    // Count modes
    bins count_up_mode   = {8'h01, 8'h09, 8'h11, 8'h19};
    bins count_down_mode = {8'h03, 8'h0B, 8'h13, 8'h1B};

    // Clock divider configurations
    bins clk_div_1 = {8'h01, 8'h03};
    bins clk_div_2 = {8'h09, 8'h0B};
    bins clk_div_4 = {8'h11, 8'h13};
    bins clk_div_8 = {8'h19, 8'h1B};
  }

  apb_transaction: cross apb_address, apb_transfer;

  tcr_config: cross apb_transfer, apb_address, apb_data {

    ignore_bins invalid_comb =
      !binsof(apb_address) intersect {8'h00};

    // Base access
    bins tcr_write = binsof(apb_transfer) intersect {packet::WRITE} &&
                     binsof(apb_address) intersect {8'h00};

    bins tcr_read  = binsof(apb_transfer) intersect {packet::READ} &&
                     binsof(apb_address) intersect {8'h00};
                   
    //==============================WRITE=============================

    // Count modes
    bins tcr_count_up_W = binsof(apb_transfer) intersect {packet::WRITE} &&
                          binsof(apb_address) intersect {8'h00} &&
                          binsof(apb_data.count_up_mode);

    bins tcr_count_down_W = binsof(apb_transfer) intersect {packet::WRITE} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.count_down_mode);

    // Clock dividers
    bins clk_div_1_mode_W = binsof(apb_transfer) intersect {packet::WRITE} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_1);
    bins clk_div_2_mode_W = binsof(apb_transfer) intersect {packet::WRITE} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_2);
    bins clk_div_4_mode_W = binsof(apb_transfer) intersect {packet::WRITE} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_4);
    bins clk_div_8_mode_W = binsof(apb_transfer) intersect {packet::WRITE} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_8);
                          
    //===========================READ======================================
                          
    // Count modes
    bins tcr_count_up_R = binsof(apb_transfer) intersect {packet::READ} &&
                          binsof(apb_address) intersect {8'h00} &&
                          binsof(apb_data.count_up_mode);

    bins tcr_count_down_R = binsof(apb_transfer) intersect {packet::READ} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.count_down_mode);

    // Clock dividers
    bins clk_div_2_mode_R = binsof(apb_transfer) intersect {packet::READ} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_2);
    bins clk_div_4_mode_R = binsof(apb_transfer) intersect {packet::READ} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_4);
    bins clk_div_8_mode_R = binsof(apb_transfer) intersect {packet::READ} &&
                            binsof(apb_address) intersect {8'h00} &&
                            binsof(apb_data.clk_div_8);
  }

  timer_status: cross apb_transfer, apb_address {
    bins tsr_read = binsof(apb_transfer) intersect {packet::READ} &&
                    binsof(apb_address) intersect {8'h01};
  }
  
  load_data: cross apb_transfer, apb_address {
    bins tdr_write = binsof(apb_transfer) intersect {packet::WRITE} &&
                     binsof(apb_address) intersect {8'h02};
  }

  set_intr_enable: cross apb_transfer, apb_address {
    bins tie_write = binsof(apb_transfer) intersect {packet::WRITE} &&
                     binsof(apb_address) intersect {8'h03};
  }

endgroup

