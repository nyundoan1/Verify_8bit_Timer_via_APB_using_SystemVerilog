class clock_div_div2_test extends base_test;
  bit [7:0] rdata;

  function new(); super.new(); endfunction

  virtual task run_scenario();
    wait (dut_vif.presetn == 1);
    repeat (5) @(posedge dut_vif.pclk);

    write(8'h02, 8'hAA);     
    div_by_chk(2, 8'h09);    
    read(8'h00, rdata);      
  endtask
endclass
