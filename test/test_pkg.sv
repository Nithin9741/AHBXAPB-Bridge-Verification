//PACKAGE_TEST_FILE
package test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "ahb_trans.sv"
`include "apb_trans.sv"

`include "ahb_config.sv"
`include "apb_config.sv"
`include "env_config.sv"

`include "ahb_sequence.sv"
`include "ahb_sequencer.sv"
`include "ahb_driver.sv"
`include "ahb_monitor.sv"
`include "ahb_agent.sv"
`include "ahb_agent_top.sv"

`include "apb_sequence.sv"
`include "apb_sequencer.sv"
`include "apb_driver.sv"
`include "apb_monitor.sv"
`include "apb_agent.sv"
`include "apb_agent_top.sv"


`include "scoreboard.sv"
`include "virtual_sequencer.sv"
`include "env.sv"
`include "virtual_sequence.sv"
`include "test.sv"

endpackage

