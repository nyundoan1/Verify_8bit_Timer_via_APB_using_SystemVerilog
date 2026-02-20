class stop_timer_while_run_test extends base_test;
  bit [7:0] cnt_before_stop;
  bit [7:0] cnt_after_stop;
  bit [7:0] cnt_after_resume;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    write(8'h00, 8'h09); // enable=1, count up, div=2
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_before_stop);
    write(8'h00, 8'h08);
    repeat (500) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_after_stop);
    write(8'h00, 8'h09);
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_after_resume);
  endtask
endclass

