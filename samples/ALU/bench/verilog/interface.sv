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

//Declaration of the interface  
interface aluinf(input logic clk,reset);
  
  //Declaration of the logic signals used in the DUT
  logic [3:0] A;
  logic [3:0] B;
  logic [2:0] sel;
  logic [5:0] result;
  
  //Declaration of a clocking block for driver and monitor to define clock signals and intervals for driver and monitor
  clocking driver_block @(posedge clk); //Providing the clock signa
    default input #1 output #1;
    output A; 
    output B;
    output sel;
    input result;
  endclocking
 
  //Driver does not take a value. It only outputs the value to the monitor
  clocking monitor_block @(posedge clk);
    default input #1 output #1;
    input A;
    input B;
    input sel;
    input result; 
  endclocking
      
  //The monitor here takes all the logic signals, specially the sum, as the sum needs to be checked which is then connected to the scoreboard for validation
  modport dri_ver (clocking driver_block, input clk, reset);
  modport moni_tor (clocking monitor_block, input clk,reset);
    
  //Modport will increase the resusability of the clocking block and the interface in other modules wherever required
endinterface
