class write_1_to_clear_test extends base_test;
  bit [7:0] status;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    write(8'h03, 8'h03);
    write(8'h00, 8'h0B);
    repeat (2500) @(posedge dut_vif.ker_clk);
    read(8'h01, status);
    write(8'h01, 8'h03);
    repeat (10) @(posedge dut_vif.ker_clk);
    read(8'h01, status);
  endtask
endclass

