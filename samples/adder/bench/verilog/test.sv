`include "environment.sv"

class test extends uvm_test;
  `uvm_component_utils(test)
  
  sequence_ seq;
  env envobj;
  
  function new(string name= "test", uvm_component parent=null); 
    super.new(name,parent);
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq=sequence_::type_id::create("seq"); //define 
    envobj=env::type_id::create("envobj",this);
  endfunction : build_phase
  
  task run_phase(uvm_phase phase); //put the seq in envi
    phase.raise_objection(this);
    seq.start(envobj.agentobj.sequencerobj);
    phase.drop_objection(this);
  endtask:run_phase
endclass:test
