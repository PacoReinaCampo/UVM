//This is the monitor file 

`define monitor_inf vif.monitor_block

class monitor extends uvm_monitor;

  virtual adder_inf vif;
  `uvm_component_utils(monitor)

  uvm_analysis_port#(seq_item)item_col_port; 
  seq_item trans_col;

  function new(string name, uvm_component parent); 
    super.new(name,parent);
    trans_col=new();
    item_col_port=new("item_col_port", this);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual adder_inf)::get(this,"","vif",vif)) begin
      `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    end
  endfunction: build_phase  

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.moni_tor.clk);
      trans_col.A = `monitor_inf.A;
      trans_col.B = `monitor_inf.B;
      @(posedge vif.moni_tor.clk);
      trans_col.sum = `monitor_inf.sum;
      $display("Values collected in monitor");
      trans_col.print();
      @(posedge vif.moni_tor.clk);
      item_col_port.write(trans_col);
    end
  endtask: run_phase
endclass: monitor
