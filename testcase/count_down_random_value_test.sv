  class count_down_random_value_test extends base_test;
    bit [7:0] val;
    function new(); 
       super.new(); 
    endfunction
    
    virtual task run_scenario();
      repeat(5) begin
        val = $urandom_range(0,255);
        write(8'h02, val);
        div_by_chk(2, 8'h0B);
      end
    endtask
  endclass
