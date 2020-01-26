`include "agent.sv"
`include "scoreboard.sv"

class env extends uvm_env;
  
  agent agentobj;
  scoreboard sboard;
  
  `uvm_component_utils(env)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agentobj=agent::type_id::create("agentobj",this);
    sboard=scoreboard::type_id::create("sboard",this);
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    agentobj.monitorobj.item_col_port.connect(sboard.item_col.analysis_export);
  endfunction: connect_phase
    
 endclass:env
    
    