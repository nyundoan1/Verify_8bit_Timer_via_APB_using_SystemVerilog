class driver;
    mailbox #(packet) s2d_mb;
    virtual dut_if dut_vif;
    packet pkt;

    event xfer_done;

    function new(virtual dut_if dut_vif, mailbox #(packet) s2d_mb);
        this.dut_vif = dut_vif;
        this.s2d_mb  = s2d_mb;
    endfunction

    task run();
        while (1) begin
            s2d_mb.get(pkt);
            $display("%0t: [driver] Get packet from stimulus", $time);
            $display("%0t: [driver] Start APB transfer", $time);
            @(posedge dut_vif.pclk);
            dut_vif.psel    = 1'b1;
            dut_vif.penable = 1'b0;
            dut_vif.paddr   = pkt.addr;
            dut_vif.pwrite  = (pkt.transfer == packet::WRITE);
            dut_vif.pwdata  = (pkt.transfer == packet::WRITE) ? pkt.data : '0;

            @(posedge dut_vif.pclk);
            dut_vif.penable = 1'b1;
            if (pkt.transfer == packet::READ) begin
                @(posedge dut_vif.pclk iff dut_vif.pready);
                pkt.data = dut_vif.prdata; 
            end else begin
                @(posedge dut_vif.pclk iff dut_vif.pready);
            end

            @(posedge dut_vif.pclk);
            dut_vif.psel    = 1'b0;
            dut_vif.penable = 1'b0;
            dut_vif.pwrite  = 1'b0;
            dut_vif.paddr   = '0;
            dut_vif.pwdata  = '0;

            -> xfer_done; 
        end
    endtask

endclass

