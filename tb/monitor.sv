class monitor;
  mailbox #(packet) m2s_mb;
  virtual dut_if dut_vif;

  function new(virtual dut_if dut_vif, mailbox #(packet) m2s_mb);
    this.dut_vif = dut_vif;
    this.m2s_mb  = m2s_mb;
  endfunction

  task run();
    packet pkt;
    forever begin
      @(posedge dut_vif.pclk iff (dut_vif.psel && !dut_vif.penable));
      pkt = new(); 
      pkt.addr = dut_vif.paddr;

      @(posedge dut_vif.pclk);
      if (dut_vif.pwrite) begin
        pkt.data     = dut_vif.pwdata;
        pkt.transfer = packet::WRITE;
        $display("%0t [monitor] WRITE : addr=%0h data=%0h", $time, pkt.addr, pkt.data);
      end else begin
        pkt.data     = dut_vif.prdata;
        pkt.transfer = packet::READ;
        $display("%0t [monitor] READ  : addr=%0h data=%0h", $time, pkt.addr, pkt.data);
      end

      if (m2s_mb == null) $fatal(1, "[MON] m2s_mb is NULL");
      m2s_mb.put(pkt);
      $display("%0t [monitor] Captured APB transaction -> sent to scoreboard", $time);
    end
  endtask
endclass

