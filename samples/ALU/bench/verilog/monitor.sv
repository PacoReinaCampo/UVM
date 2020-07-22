////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              Universal Verification Methodology                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2020-2021 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

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
