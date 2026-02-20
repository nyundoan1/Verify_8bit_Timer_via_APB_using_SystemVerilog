 class reserved_region_test extends base_test;
    bit [7:0] data;
    function new(); super.new(); endfunction
    virtual task run_scenario();
      write(8'h09, 8'hFF);
      read(8'h09, data);
    endtask
  endclass
