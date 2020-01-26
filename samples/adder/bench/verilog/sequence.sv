//This is file which will generate the sequence which will take the sequence items on the seqeuncer in a particular sequence

class sequence_ extends uvm_sequence #(seq_item);
  `uvm_object_utils(sequence_)
  `uvm_declare_p_sequencer(sequencer)
  
  function new(string name = "sequence_");
    super.new(name);
  endfunction
  
  //Creating the sequence
  virtual task body();
    repeat(10) begin
      req=seq_item::type_id::create("req");
      start_item(req);
      assert (req.randomize());
      finish_item(req);
    end
  endtask
endclass
