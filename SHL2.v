module SHL2(input [31:0] a,input [31:0] pcn, output[31:0]b);//no <<2and combine
reg [31:0] an;


always@(*)
begin
 an[25:0]=a[25:0];
 an[31:26]=pcn[31:26];

end
 assign b=an;
endmodule