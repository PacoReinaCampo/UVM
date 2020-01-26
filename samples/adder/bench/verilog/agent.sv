// This is agent file which will combine together the sequencer, driver and monitor

`include "sequenceitems.sv"
`include "sequencer.sv"
`include "sequence.sv"
`include "driver.sv"
`include "monitor.sv"
 
class agent extends uvm_agent; 
  sequencer sequencerobj;
  driver driverobj;
  monitor monitorobj;
   
  `uvm_component_utils(agent) 
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction:new
    
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
        
    driverobj    = driver::type_id::create("driverobj",this);
    sequencerobj = sequencer::type_id::create("sequencerobj",this);  
    monitorobj   = monitor::type_id::create("monitorobj",this);
  endfunction: build_phase
    
  function void connect_phase(uvm_phase phase);
   driverobj.seq_item_port.connect(sequencerobj.seq_item_export);
  endfunction: connect_phase
endclass: agent
