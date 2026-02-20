class count_down_test_div2 extends base_test;
    packet pkt;
    bit [7:0] data;

    function new();
        super.new();
    endfunction

    virtual task run_scenario();
        wait (dut_vif.presetn == 1);
        repeat (5) @(posedge dut_vif.pclk);
        div_by_chk(2, 8'h0B);
        read(8'h01, data);
        wait (dut_vif.interrupt == 1);
    endtask
endclass

