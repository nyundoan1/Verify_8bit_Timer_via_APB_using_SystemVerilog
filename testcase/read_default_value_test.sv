class read_default_value_test extends base_test;
    bit [7:0] data;
    function new(); super.new(); endfunction
    virtual task run_scenario();
      wait(dut_vif.presetn == 1);
      read(8'h00, data); $display("TCR default = 0x%0h", data);
      read(8'h01, data); $display("TSR default = 0x%0h", data);
      read(8'h02, data); $display("TDR default = 0x%0h", data);
      read(8'h03, data); $display("TIE default = 0x%0h", data);
    endtask
  endclass
