class environment;
  stimulus    stim;
  driver      drv;
  monitor     mon;
  scoreboard  sb;

  mailbox #(packet) s2d_mb;
  mailbox #(packet) m2s_mb;

  virtual dut_if dut_vif;

  function new(virtual dut_if dut_vif);
    this.dut_vif = dut_vif;
  endfunction

  function void build();
    $display("%0t: [environment] build", $time);

    s2d_mb = new();
    m2s_mb = new();

    stim = new(s2d_mb);
    drv  = new(dut_vif, s2d_mb);
    mon  = new(dut_vif, m2s_mb);
    sb   = new(m2s_mb);

    // safety checks
    if (s2d_mb==null || m2s_mb==null || stim==null || drv==null || mon==null || sb==null)
      $fatal(1, "[ENV] build failed: some handle is NULL");
  endfunction

  task run();
    fork
      begin : STIM_T  if (stim==null) $fatal(1,"stim NULL"); stim.run(); end
      begin : DRV_T   if (drv ==null) $fatal(1,"drv  NULL"); drv.run();  end
      begin : MON_T   if (mon ==null) $fatal(1,"mon  NULL"); mon.run();  end
      begin : SCB_T   if (sb  ==null) $fatal(1,"sb   NULL"); sb.run();   end
    join_none
  endtask
endclass

