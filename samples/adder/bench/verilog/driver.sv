//This is the driver file 

`define driver_inf vif.dri_ver.driver_block

class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)

  virtual adder_inf vif;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual adder_inf)::get(this, "","vif",vif)) begin
      `uvm_fatal("No_vif", {"Virtual interface must be set for: ",get_full_name(),".vif"});
    end
  endfunction: build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done();
    end
  endtask: run_phase

  virtual task drive();
    @(posedge vif.dri_ver.clk);
    `driver_inf.A <= req.A;
    `driver_inf.B <= req.B;
    @(posedge vif.dri_ver.clk);
    req.sum <= `driver_inf.sum;
    @(posedge vif.dri_ver.clk);
  endtask: drive
endclass: driver
