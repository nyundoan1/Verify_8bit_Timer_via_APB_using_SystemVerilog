class read_write_value_test extends base_test;
    bit [7:0] wr, rd;
    function new(); super.new(); endfunction
    virtual task run_scenario();
      wait(dut_vif.presetn == 1);
      wr = 8'hA5; write(8'h02, wr); read(8'h02, rd);
      if (rd != wr) error++;
    endtask
  endclass
