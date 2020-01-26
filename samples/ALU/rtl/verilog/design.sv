// Code your design here
module alu (
  input  logic       clk,
  input  logic       reset,
  input  logic [3:0] A,
  input  logic [3:0] B,
  input  logic [2:0] sel,
  output logic [4:0] result
);

  always@(posedge clk) begin
    if(!reset) begin
      result <= 5'bxxxxx;
    end
    else begin
      case(sel)
        3'b000: result <= A + B ; //Addition
        3'b001: result <= A + (~B + 1) ; //Subtraction
        3'b010: result <= A & B ; //Logical AND
        3'b011: result <= A | B ; //Logical OR
        3'b100: result <= A * B ; //Multiplication
        3'b101: result <= A ^ B ; //Logical XOR
        3'b110: result <= A % B ; //Modulo operator
        3'b111: result <= A / B ; //Division
        default: $display("Invalid operation selected");
      endcase
    end
  end
endmodule
