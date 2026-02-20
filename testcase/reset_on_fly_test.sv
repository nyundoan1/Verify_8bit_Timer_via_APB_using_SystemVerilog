class reset_on_fly_test extends base_test;
  bit [7:0] cnt_before_reset;
  bit [7:0] cnt_after_reset;
  bit [7:0] tcr_after_reset;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    write(8'h00, 8'h09);
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_before_reset);
    dut_vif.presetn = 0;
    repeat (20) @(posedge dut_vif.pclk);  
    dut_vif.presetn = 1;
    repeat (5) @(posedge dut_vif.pclk);
    read(8'h02, cnt_after_reset);
    read(8'h00, tcr_after_reset);
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_after_reset);
  endtask
endclass

