module MUX4(input [1:0]crl,input [31:0]a,input [31:0]b,input [31:0]c,input [31:0]d,output[31:0]e);

reg [31:0]temp;
always@(*)
begin
case(crl)
0:temp=a;
1:temp=b;
2:temp=c;
3:temp=d;
endcase
end
assign e=temp;
endmodule