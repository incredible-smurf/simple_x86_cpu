module MUX(input [31:0]a,input [31:0]b, input crl,output [31:0]c);

reg [31:0]temp;
always @(*)
begin 
 if(crl==0)
 temp=a;
 else
 temp=b;
end
assign c=temp;
endmodule
