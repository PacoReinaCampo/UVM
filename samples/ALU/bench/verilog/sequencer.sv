//This file is the sequencer that will take the stimuli to the driver

class sequencer extends uvm_sequencer#(seq_item);
  `uvm_component_utils(sequencer)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
endclass
