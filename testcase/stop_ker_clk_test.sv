class stop_ker_clk_test extends base_test;
  bit [7:0] cnt_before_stop;
  bit [7:0] cnt_after_stop;
  bit [7:0] cnt_after_resume;
  bit stop_clk = 0;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    write(8'h00, 8'h09);
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_before_stop);
    stop_clk = 1;
    #500ns; 
    read(8'h02, cnt_after_stop);
    stop_clk = 0;
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_after_resume);
  endtask
endclass

