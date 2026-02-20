class scoreboard;
  mailbox #(packet) m2s_mb;

  packet      pkt;
  TIMER_GROUP cov;   

  function new(mailbox #(packet) m2s_mb_i = null);
    if (m2s_mb_i == null) begin
      $display("[%0t][Scoreboard] mailbox input is NULL -> creating one", $time);
      this.m2s_mb = new();
    end else begin
      this.m2s_mb = m2s_mb_i;
    end

    this.pkt = new();
    this.cov = new(this.pkt);
  endfunction

  task run();
    forever begin
      if (m2s_mb == null) $fatal(1, "[Scoreboard] m2s_mb is NULL before get()");
      m2s_mb.get(this.pkt);   
      cov.sample();  
    end
  endtask
endclass

