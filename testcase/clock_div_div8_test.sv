class clock_div_div8_test extends base_test;
  bit [7:0] rdata;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    repeat (5) @(posedge dut_vif.pclk);

    write(8'h02, 8'hAA);   
    div_by_chk(8, 8'h19);    
    read(8'h00, rdata);      
  endtask
endclass
