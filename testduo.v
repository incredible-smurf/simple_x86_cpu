module testduo;
wire [31:0]s1,s2,c16,s3,s4,c1,s5,s6,c13,c12,s7,s8,c2,s9,s10,s11,c5,s12,s13,s14,s15,s16,c6,s17,s18,s19,s20,s21,c7,c10,s22,c9,c14,s23,s24,s25,c8,c15,c4,c3,c11,pcrstl;
reg clk,int1,pcrst,go;

initial
begin
clk=0;
int1=1;
//pcrst=0;
end
//assign pcrstl=pcrst;
always #50 clk=~clk;
assign s22=int1;
assign c15=c14&c4;
assign c16=c15|c3;
assign s6=s18;
clk_pc pc(.clk(clk),.wena(c16),.data_in(s2),.data_out(s1));
MUX mux1(.a(s1),.b(s3),.crl(c1),.c(s4));
MUXfour mux2(.a(s10),.b(s10),.crl(c5),.c(s12));
MUX mux3(.a(s3),.b(s13),.crl(c11),.c(s14));
MUX mux4(.a(s1),.b(s17),.crl(c7),.c(s21));
MUX4 mux5(.crl(c10),.a(s18),.b(s22),.c(s19),.d(s20),.e(s11));
MUX4 mux6(.crl(c8),.a(s23),.b(s3),.c(s25),.e(s2));
clkram ram1(.wena(c13),.rena(c12),.addr(s4),.data_in(s6),.data_out(s5),.clk(clk));
clk_ir ir(.d(s5),.b(s8),.a(s7),.wena(c2),.clk(clk),.s9(s9),.all(s10));
clk_temp t1(.clk(clk),.a(s5),.b(s13));
clk_temp t2(.clk(clk),.a(s16),.b(s17));
clk_temp t3(.clk(clk),.a(s15),.b(s18));
clk_temp t4(.clk(clk),.a(s23),.b(s3));
RF rf(.clk(clk),.we(c6),.raddr1(s7),.raddr2(s8),.waddr(s12),.wdata(s14),.rdata1(s16),.rdata2(s15));
sixteentodou se(.a(s10),.b(s19));
//OSHL2 sh1(.a(s19),.b(s20));
//OSHL2 sh2(.a(s9),.b(s24));
assign s24=s9;
assign s20=s19;
alu alu1(.a(s21),.b(s11),.aluc(c9),.zero(c14),.r(s23));
clk_cu cu(.clk(clk),.a(s10),.iord(c1),.irwr(c2),.pcwr(c3),.pcwrcond(c4),.regdst(c5),.regwr(c6),.alusrca(c7),.pcsrc(c8),.aluop(c9),.alusrcb(c10),.memtoreg(c11),.memrd(c12),.memwr(c13));
assign s25[31:26]=s1[31:26];
assign s25[25:0]=s24[25:0];
endmodule
