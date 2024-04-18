module alu_12_bit( A, B, cout, Result, alu_control);
  input [11:0] A,B;
  input [1:0]  alu_control;
  
  output reg        cout;
  output reg [11:0] Result;
  
  always@(*)
    begin
      case(alu_control)
        0:{cout,Result}=A+B;
        1:{cout,Result}=A+~B+1;
        2:Result=A & B;
        3:Result=A | B;
      endcase
    end
endmodule