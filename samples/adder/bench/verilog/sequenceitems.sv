//This is a file to create sequence items that will be the stimuli to the DUT

//Creation of a seq_items class that extends the parent UVM class
class seq_item extends uvm_sequence_item; 
  
  //Registration of the DUT signals and its data type in the UVM Factory 
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(A,UVM_ALL_ON)
  `uvm_field_int(B,UVM_ALL_ON)
  `uvm_field_int(sum,UVM_ALL_ON)
  `uvm_object_utils_end
  
  rand bit [7:0] A;
  rand bit [7:0] B;

  bit [8:0] sum;
  
  function new(string name= "seq_item");
    super.new(name);
  endfunction             
  
  /*These contraints are added for even the randomization of B to be in this range. This can be tweaked in various ways.*/
  constraint constr{B inside {3,6,8,9,10,25};}; 
endclass
