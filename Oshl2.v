module OSHL2(input [31:0] a, output[31:0]b);//shl and combine
reg [31:0] an;


always@(*)
begin
 an[31:0]=a[31:0];
 an=an<<2;
end
 assign b=an;
endmodule
