`timescale 1ns/1ps

module testbench; 
  import timer_pkg::*;
  import test_pkg::*;
 
  dut_if d_if();

  timer_top u_dut(
    .ker_clk(d_if.ker_clk),       
    .pclk(d_if.pclk),       
    .presetn(d_if.presetn),    
    .psel(d_if.psel),       
    .penable(d_if.penable),    
    .pwrite(d_if.pwrite),     
    .paddr(d_if.paddr),      
    .pwdata(d_if.pwdata),     
    .prdata(d_if.prdata),     
    .pready(d_if.pready),     
    .interrupt(d_if.interrupt)
  );
    
  bit [7:0] count;
  assign count = u_dut.u_counter.cnt;

  initial begin
    d_if.presetn = 0;
    #100ns d_if.presetn = 1;
  end

  initial begin
    d_if.pclk = 0;
    forever #10ns d_if.pclk = ~d_if.pclk;
  end
 
  initial begin
    d_if.ker_clk = 1;
    forever #2.5ns d_if.ker_clk = ~d_if.ker_clk;
  end

  initial begin
    #1ms;
    $display("[testbench] Time out....Seems your tb is hang!");
    $finish;
  end

  base_test                     base;
  count_down_test_div2          count_down_div2_obj          = new();
  count_up_test_div2            count_up_div2_obj            = new();
  count_down_test_div4          count_down_div4_obj          = new();
  count_up_test_div4            count_up_div4_obj            = new();
  count_down_test_div8          count_down_div8_obj          = new();
  count_up_test_div8            count_up_div8_obj            = new();
  read_default_value_test       read_def_val_obj             = new();
  read_write_value_test         read_write_val_obj           = new();
  reset_on_fly_test             rst_on_fly_obj               = new();
  write_1_to_clear_test         w_1_to_clear_obj             = new();
  reserved_region_test          re_region_obj                = new();
  clock_div_no_div_test         clk_div_no_div_obj           = new();
  clock_div_div2_test           clk_div_div2_obj             = new();
  clock_div_div4_test           clk_div_div4_obj             = new();
  clock_div_div8_test           clk_div_div8_obj             = new();
  change_clk_div_on_run_test    ch_clk_div_on_run_obj        = new();
  stop_ker_clk_test             stop_ker_clk_obj             = new();
  count_up_data_test            count_up_data_obj            = new();
  count_down_data_test          count_down_data_obj          = new();
  count_up_random_value_test    count_up_rand_val_obj        = new();
  count_down_random_value_test  count_down_rand_val_obj      = new();
  write_load_while_run_test     write_load_run_obj           = new();
  stop_timer_while_run_test     stop_timer_run_obj           = new();
  timer_disable_test            timer_disable_obj            = new();
  underflow_interrupt_test      underflow_intr_obj           = new();
  overflow_interrupt_test       overflow_intr_obj            = new();
  disable_interrupt_test        disable_intr_obj             = new();

  initial begin
    if ($test$plusargs("count_down_test_div2")) begin
      base = count_down_div2_obj;
    end else if($test$plusargs("count_up_test_div2")) begin
      base = count_up_div2_obj;
    end else if($test$plusargs("count_down_test_div4")) begin
      base = count_down_div4_obj;
    end else if($test$plusargs("count_up_test_div4")) begin
      base = count_up_div4_obj;
    end else if($test$plusargs("count_down_test_div8")) begin
      base = count_down_div8_obj;
    end else if($test$plusargs("count_up_test_div8")) begin
      base = count_up_div8_obj;
    end else if($test$plusargs("read_default_value_test")) begin
      base = read_def_val_obj;
    end else if($test$plusargs("read_write_value_test")) begin
      base = read_write_val_obj;
    end else if($test$plusargs("reset_on_fly_test")) begin
      base = rst_on_fly_obj;
    end else if($test$plusargs("write_1_to_clear_test")) begin
      base = w_1_to_clear_obj;
    end else if($test$plusargs("reserved_region_test")) begin
      base = re_region_obj;
    end else if($test$plusargs("clock_div_no_div_test")) begin
      base = clk_div_no_div_obj;
    end else if($test$plusargs("clock_div_div2_test")) begin
      base = clk_div_div2_obj;
    end else if($test$plusargs("clock_div_div4_test")) begin
      base = clk_div_div4_obj;
    end else if($test$plusargs("clock_div_div8_test")) begin
      base = clk_div_div8_obj;
    end else if($test$plusargs("change_clk_div_on_run_test")) begin
      base = ch_clk_div_on_run_obj;
    end else if($test$plusargs("stop_ker_clk_test")) begin
      base = stop_ker_clk_obj;
    end else if($test$plusargs("count_up_data_test")) begin
      base = count_up_data_obj;
    end else if($test$plusargs("count_down_data_test")) begin
      base = count_down_data_obj;
    end else if($test$plusargs("count_up_random_value_test")) begin
      base = count_up_rand_val_obj;
    end else if($test$plusargs("count_down_random_value_test")) begin
      base = count_down_rand_val_obj;
    end else if($test$plusargs("write_load_while_run_test")) begin
      base = write_load_run_obj;
    end else if($test$plusargs("stop_timer_while_run_test")) begin
      base = stop_timer_run_obj;
    end else if($test$plusargs("timer_disable_test")) begin
      base = timer_disable_obj;
    end else if($test$plusargs("underflow_interrupt_test")) begin
      base = underflow_intr_obj;
    end else if($test$plusargs("overflow_interrupt_test")) begin
      base = overflow_intr_obj;
    end else if($test$plusargs("disable_interrupt_test")) begin
      base = disable_intr_obj;
    end else begin
      $display("WARNING: No +TESTNAME specified! Defaulting to count_up_test_div2.");
      base = count_up_div2_obj;
    end

    base.dut_vif = d_if;
    base.run_test();
  end
endmodule

