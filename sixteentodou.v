module sixteentodou(input [31:0]a,output [31:0]b);

reg [31:0]ac;
reg [31:0]i;
initial 
begin
ac=0;
i=0;
end

always @(a)
begin
ac[15:0]=a[15:0];
if (a[15]==0)
 for (i=16;i<=31;i=i+1)
  ac[i]=0;
else
 for (i=16;i<=31;i=i+1)
  ac[i]=1;
end
assign b=ac;

endmodule