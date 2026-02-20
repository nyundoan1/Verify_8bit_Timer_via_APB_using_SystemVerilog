package test_pkg;
  import timer_pkg::*;

  // Base class
  `include "base_test.sv"

  // --------------------------------------------------
  // 1. REGISTER TESTS
  // --------------------------------------------------
  `include "read_default_value_test.sv"
  `include "read_write_value_test.sv"
  `include "reset_on_fly_test.sv"
  `include "write_1_to_clear_test.sv"
  `include "reserved_region_test.sv"

  // --------------------------------------------------
  // 2. CLOCK DIVISOR TESTS
  // --------------------------------------------------
  `include "clock_div_no_div_test.sv"
  `include "clock_div_div2_test.sv"
  `include "clock_div_div4_test.sv"
  `include "clock_div_div8_test.sv"
  `include "change_clk_div_on_run_test.sv"
  `include "stop_ker_clk_test.sv"

  // --------------------------------------------------
  // 3. COUNTER TESTS
  // --------------------------------------------------
  `include "count_up_test_div2.sv"
  `include "count_down_test_div2.sv"
  `include "count_up_test_div4.sv"
  `include "count_down_test_div4.sv"
  `include "count_up_test_div8.sv"
  `include "count_down_test_div8.sv"
  `include "count_up_data_test.sv"
  `include "count_down_data_test.sv"
  `include "count_up_random_value_test.sv"
  `include "count_down_random_value_test.sv"
  `include "write_load_while_run_test.sv"
  `include "stop_timer_while_run_test.sv"
  `include "timer_disable_test.sv"

  // --------------------------------------------------
  // 4. INTERRUPT TESTS
  // --------------------------------------------------
  `include "underflow_interrupt_test.sv"
  `include "overflow_interrupt_test.sv"
  `include "disable_interrupt_test.sv"

endpackage

