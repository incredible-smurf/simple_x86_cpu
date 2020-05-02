module MUXfour(input [31:0]a,input [31:0]b, input crl,output [4:0]c);

reg  [4:0] temp1;
reg  [4:0] temp2;
reg  [4:0] temp;
always @(*)
begin 
 temp1 [4:0] =a[20:16];
 temp2 [4:0] =b[15:11];
 if(crl==0)
 temp=temp1;
 else
 temp=temp2;
end
assign c=temp;
endmodule
