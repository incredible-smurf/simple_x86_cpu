module clk_ir(input [31:0]d,input clk,input wena,output [4:0]a,output[4:0]b,output[15:0] c ,output [5:0]code,output [25:0]s9,output [31:0]all);


reg [31:0]temps;
always @(posedge clk)
begin 
if(wena)
temps=d;
end

initial
temps=32'b0;

assign a[4:0]=temps[25:21];
assign b[4:0]=temps[20:16];
assign c[15:0]=temps[15:0];
assign code[5:0]=temps[31:26];
assign s9[25:0]=temps[25:0];
assign all=temps;
endmodule