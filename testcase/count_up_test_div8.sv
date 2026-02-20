class count_up_test_div8 extends base_test;
    packet pkt;
    bit [7:0] data;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
        wait (dut_vif.presetn == 1);
        repeat (5) @(posedge dut_vif.pclk);
        div_by_chk(8, 8'h19);
        read(8'h01, data);
        wait (dut_vif.interrupt == 1);
    endtask
endclass

