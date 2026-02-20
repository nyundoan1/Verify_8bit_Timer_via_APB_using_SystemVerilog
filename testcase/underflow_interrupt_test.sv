 class underflow_interrupt_test extends base_test;
    bit [7:0] data;
    function new(); super.new(); endfunction
    virtual task run_scenario();
      write(8'h03, 8'h02);
      div_by_chk(2, 8'h0B);
      read(8'h01, data);
    endtask
  endclass
