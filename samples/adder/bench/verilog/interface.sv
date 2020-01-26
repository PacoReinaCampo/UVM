//This is the interface module that will act as a bridge between the monitor and driver to drive the stimuli/sequence items that are used to verify the DUT

//Declaration of the interface  
interface adder_inf(input logic clk,reset);

  //Declaration of the logic signals used in the DUT
  logic [7:0] A;
  logic [7:0] B;
  logic [8:0] sum;

  //Declaration of a clocking block for driver and monitor to define clock signals and intervals for driver and monitor
  clocking driver_block @(posedge clk); //Providing the clock signa
    default input #1 output #1;
    output A; 
    output B;
    input sum;
  endclocking

  //Driver does not take a value. It only outputs the value to the monitor
  clocking monitor_block @(posedge clk);
    default input #1 output #1;
    input A;
    input B;
    input sum; 
  endclocking

  //The monitor here takes all the logic signals, specially the sum, as the sum needs to be checked which is then connected to the scoreboard for validation
  modport dri_ver (clocking driver_block, input clk, reset);
  modport moni_tor (clocking monitor_block, input clk,reset);

  //Modport will increase the resusability of the clocking block and the interface in other modules wherever required
endinterface
