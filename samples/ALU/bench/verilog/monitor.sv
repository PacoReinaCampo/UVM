//This is the monitor file 

`define monitor_inf vif.monitor_block

class monitor extends uvm_monitor;

  virtual aluinf vif;
  `uvm_component_utils(monitor)

  uvm_analysis_port#(seq_item)item_col_port; 
  seq_item seq_col;
  seq_item item_col;

  function new(string name, uvm_component parent); 
    super.new(name,parent);
    seq_col=new();
    item_col_port=new("item_col_port", this);
  endfunction: new

  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual aluinf)::get(this,"","vif",vif)) begin
      `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    end
  endfunction: build_phase  

  //Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      //@(posedge vif.moni_tor.clk);
      @(posedge vif.clk)
      //trans_col.A = `monitor_inf.A;
      //trans_col.B = `monitor_inf.B;
      seq_col.A = vif.A;
      seq_col.B = vif.B;
      seq_col.sel = vif.sel;
      //@(posedge vif.moni_tor.clk);
      //trans_col.sum = `monitor_inf.sum;
      @(posedge vif.clk)
      seq_col.result = vif.result;
      //$display("Values collected in monitor");
      //trans_col.print();
      //@(posedge vif.moni_tor.clk);
      @(posedge vif.clk)
      //item_col_port.write(trans_col);
      `uvm_info (get_type_name(),$sformatf("From monitor the result is 4'b %b",seq_col.result),UVM_MEDIUM)
      $cast(item_col,seq_col.clone());
      item_col_port.write(item_col);
    end
  endtask: run_phase
endclass: monitor
