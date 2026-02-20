 class count_down_data_test extends base_test;
    
    bit [7:0] rdata;
    
    function new(); 
       super.new(); 
    endfunction
    
    virtual task run_scenario();
      write(8'h02, 8'hAA);
      div_by_chk(2, 8'h0B);
      read(8'h00, rdata);
    endtask
  endclass
