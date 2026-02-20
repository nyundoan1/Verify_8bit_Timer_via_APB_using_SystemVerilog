class write_load_while_run_test extends base_test;
  bit [7:0] before_cnt;
  bit [7:0] after_cnt;
  bit [7:0] load_data;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    // Enable interrupt (optional)
    write(8'h03, 8'h03);
    // Load initial value into TDR
    load_data = 8'h55;
    write(8'h02, load_data);
    // Start timer (count up, div=2)
    write(8'h00, 8'h09);
    repeat (1000) @(posedge dut_vif.ker_clk);
    // Read current counter value
    read(8'h02, before_cnt);
    // Write again to TCR with LOAD=1 (bit[2])
    // => expect counter stops and reloads TDR value
    write(8'h00, 8'h0D);
    repeat (5) @(posedge dut_vif.ker_clk);
    // Read counter after reload
    read(8'h02, after_cnt);
  endtask
endclass

