module clk_temp(input clk,input [31:0]a,output [31:0]b);

reg [31:0] temp;


always@(posedge clk)
begin
temp=a;
end
assign b=temp;
endmodule
