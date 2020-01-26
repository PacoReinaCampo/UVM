//This is the driver file 

`define driver_inf vif.dri_ver.driver_block

class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)
  
  virtual aluinf vif;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  //Build phase
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual aluinf)::get(this, "","vif",vif))
      `uvm_fatal("No_vif", {"Virtual interface must be set for: ",get_full_name(),".vif"});
  endfunction: build_phase
  
  //Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask: run_phase
  
  //Drive task phase
  virtual task drive();
    //@(posedge vif.dri_ver.clk);
    @(posedge vif.clk)
    //`driver_inf.A <= req.A;
    //`driver_inf.B <= req.B;
    vif.A <= req.A;
    vif.B <= req.B;
    vif.sel <= req.sel;
    repeat(2)
    //@(posedge vif.dri_ver.clk);
    @(posedge vif.clk)
    //req.sum <= `driver_inf.sum;
    req.result <= vif.result;  
    //@(posedge vif.dri_ver.clk);
  endtask: drive
endclass: driver
