//This is a file to create sequence items that will be the stimuli to the DUT

//Creation of a seq_items class that extends the parent UVM class
class seq_item extends uvm_sequence_item; 
  
  //Registration of the DUT signals and its data type in the UVM Factory 
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(A,UVM_ALL_ON)
  `uvm_field_int(B,UVM_ALL_ON)
  `uvm_field_int(sel,UVM_ALL_ON)
  `uvm_field_int(result,UVM_ALL_ON)
  `uvm_object_utils_end
  
  rand bit [3:0] A;
  rand bit [3:0] B;

  randc bit [2:0] sel;

  bit [4:0] result;
  
  function new(string name= "seq_item");
    super.new(name);
  endfunction             
  
  /*These contraints are added for even the randomization of B to be in this range. This can be tweaked in various ways.*/
  constraint constr{A > B;}; 
  constraint cons{A inside {3,5,6,9,10,15};};
  constraint constra{sel inside {4,6,7,8};};
endclass
               
               
