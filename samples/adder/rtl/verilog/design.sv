// Code your design here
module adder (
  input  logic       clk, 
  input  logic       reset,
  input  logic [7:0] A,
  input  logic [7:0] B,
  output logic [8:0] sum
);

  always @(posedge clk) begin
    if(reset) begin
      sum=5'b0;
    end
    else begin
      sum=A+B;
    end
  end
endmodule
