class base_test;
  environment env;
  virtual dut_if dut_vif;
  bit[7:0] wdata;
  bit[7:0] rdata;
  int error = 0;
  int t1,t2,t3,t4;

  function new();
  endfunction

  function void build();
    env = new(dut_vif); 
    env.build();
  endfunction

  task write(bit[7:0] addr, bit[7:0] data);
    packet pkt = new();
    pkt.addr = addr;
    pkt.data = data;
    pkt.transfer = packet::WRITE;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
  endtask
  
  task read(bit[7:0] addr, ref bit[7:0] data);
    packet pkt = new();
    pkt.addr = addr;
    pkt.transfer = packet::READ;
    env.stim.send_pkt(pkt);
    @(env.drv.xfer_done);
    data = pkt.data;
  endtask

  function void compare(bit[7:0]exp_val);
	  if(rdata !== exp_val) begin
		  $display("%0t: [FAIL] rdata does not match with expect value(ACT:%h | EXP:%h)",$time,rdata,exp_val);
		  error++;
	  end else
		  $display("%0t: [PASS] rdata match with expect value(ACT:%h | EXP:%h)",$time,rdata,exp_val);
	  $display("------------------------------------------------------------------------------------");
  endfunction

task div_by_chk(int div, bit [7:0] data);
  bit [7:0] temp;

  // Enable both overflow & underflow interrupts
  write(8'h03, 8'h03);

  // Mode setup: nếu là count_down (bit[1]=1) thì pre-load 0x02
  if (data[1]) begin
    write(8'h00, 8'h02);
  end

  // Ghi cấu hình chính vào TCR
  write(8'h00, data);

  // Chờ counter chạy đủ để tràn (256 * divisor - offset nhỏ)
  repeat (256 * div - 8) @(posedge dut_vif.ker_clk);

  // Đọc TSR lần 1
  read(8'h01, rdata);

  // =========================
  // COUNT DOWN mode
  // =========================
  if (data[1]) begin
    if (rdata[1] != 0) begin
      $display("########## [FAIL] Underflow bit raised too soon");
      error++;
    end else begin
      $display("########## [PASS] Underflow bit did not raise soon");
      repeat (3) @(posedge dut_vif.pclk);
      read(8'h01, rdata);
      if (rdata[1] != 1) begin
        $display("######### [FAIL] Underflow bit not triggered");
        error++;
      end else begin
        $display("######### [PASS] Underflow bit triggered");
        repeat (3) @(posedge dut_vif.pclk);   // chờ đồng bộ interrupt
        if (dut_vif.interrupt != 1) begin
          $display("########## [FAIL] Interrupt not asserted");
          error++;
        end else begin
          $display("######### [PASS] Interrupt asserted");
        end
      end
    end

  // =========================
  // COUNT UP mode
  // =========================
  end else begin
    if (rdata[0] != 0) begin
      $display("########## [FAIL] Overflow bit raised too soon");
      error++;
    end else begin
      $display("########## [PASS] Overflow bit did not raise soon");
      repeat (3) @(posedge dut_vif.pclk);
      read(8'h01, rdata);
      if (rdata[0] != 1) begin
        $display("########### [FAIL] Overflow bit not triggered");
        error++;
      end else begin
        $display("########### [PASS] Overflow bit triggered");
        repeat (3) @(posedge dut_vif.pclk);   // chờ đồng bộ interrupt
        if (dut_vif.interrupt != 1) begin
          $display("########### [FAIL] Interrupt not asserted");
          error++;
        end else begin
          $display("########### [PASS] Interrupt asserted");
        end
      end
    end
  end

  // Clear flag sau test
  write(8'h01, 8'h03);
  read(8'h01, temp);
  $display("########### TSR cleared -> %0h", temp);
  $display("--------------------------------------------------");
endtask



  virtual task run_scenario();
  endtask

  task run_test();
    build();
    fork
      env.run();
      run_scenario();
    join_any
      //env.sb.report(error_cnt);
      #15us;
      $display("%0t: [base_test] End simulation",$time);
      $finish;
  endtask
endclass
