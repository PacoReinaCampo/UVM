`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "test.sv"

module alutop;
 
  bit clk;
  bit reset;
   
  always #5 clk = ~clk;
   
  initial begin
    reset = 1;
    #5 reset = 0;
  end
  
  aluinf intf(clk,reset);
  
  alu dut (
    .clk    (intf.clk),
    .reset  (intf.reset),
    .A      (intf.A),
    .B      (intf.B),
    .sel    (intf.sel),
    .result (intf.result)
  );
  
  initial begin
    uvm_config_db#(virtual aluinf)::set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd"); $dumpvars;
  end
   
  initial begin
    run_test("test");
  end
endmodule
