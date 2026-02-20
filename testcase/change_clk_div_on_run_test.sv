class change_clk_div_on_run_test extends base_test;
  bit [7:0] cnt_div2_start, cnt_div2_end;
  bit [7:0] cnt_div4_end;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    write(8'h03, 8'h03);
    write(8'h02, 8'h00);
    write(8'h00, 8'h09);
    repeat (1000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_div2_start);
    repeat (2000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_div2_end);
    write(8'h00, 8'h11);
    repeat (2000) @(posedge dut_vif.ker_clk);
    read(8'h02, cnt_div4_end);
  endtask
endclass

