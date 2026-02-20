class timer_disable_test extends base_test;
  bit [7:0] before_cnt;
  bit [7:0] after_cnt;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    write(8'h03, 8'h03);
    write(8'h02, 8'hAA);
    write(8'h00, 8'h09);
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, before_cnt);
    write(8'h00, 8'h08);
    repeat (200) @(posedge dut_vif.ker_clk);
    read(8'h02, after_cnt);
  endtask
endclass

