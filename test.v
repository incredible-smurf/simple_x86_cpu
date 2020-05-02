module test;
wire [31:0] s1,s2,s3,w1,s4,s5,s6,c1,s7,s8,s9,s10,s11,s12,c3,c4,s13,c7,s14,s15,c5,c6,c8,s16,c11,c2,c13,c15;
wire c12,c10,c9,c14;
reg clk,rst,ena_pc;//pc





initial//pc
   begin
rst=0;
clk=0;
   end
always #50 clk=~clk;
assign c11=c9&c10;
assign c12=~c10;
assign c13=c14&c12;
assign c15=c11|c13;

reg [31:0]alu1_a;//alu1
reg[3:0]alu1_crl;
wire [31:0]alu1_al;
wire[3:0]alu1_crll;

initial//alu_1&&alu_2
   begin
alu1_a=32'b1;
alu1_crl=4'b0000;//+
   end
assign alu1_al=alu1_a;
assign alu1_crll=alu1_crl;


reg wena_im,rena_im;//IM
wire wena_iml,rena_iml;
initial
   begin
wena_im=0;
rena_im=1;
   end
assign wena_iml=wena_im;
assign rena_iml=rena_im;



ram im(.wena(wena_iml),.rena(rena_iml),.addr(s1),.data_out(s4));
ram data(.rena(c5),.wena(c6),.addr(s14),.data_in(s10),.data_out(s15),.clk(clk),.order(s4));
pca pc1(.clk(clk),.rst(rst),.data_in(s2),.data_out(s1));
alu alu1(.a(alu1_al),.b(s1),.r(s3),.aluc(alu1_crll));
//alu alu2(.a(s3),.b(s8),.r(s9),.aluc(alu1_crll));
alu alu2(.a(s3),.b(s5),.r(s9),.aluc(alu1_crll));
alu alu3(.a(s11),.b(s13),.aluc(c7),.r(s14),.zero(c10));
sixteentodou se1(.a(s4),.b(s5));
MUXfour mux1(.a(s4),.b(s4),.crl(c1),.c(s6));//mux1
MUX     mux2(.a(s10),.b(s5),.crl(c4),.c(s13));
MUX     mux3(.a(s14),.b(s15),.crl(c8),.c(s12));
MUX     mux4(.a(s3),.b(s9),.crl(c15),.c(s16));
MUX     mux5(.a(s16),.b(s7),.crl(c2),.c(s2));
SHL2    shl(.a(s4),.b(s7),.pcn(s3));
//OSHL2   shl2(.a(s5),.b(s8));
RF   rf(.we(c3),.raddr1(s4[25:21]),.raddr2(s4[20:16]),.waddr(s6),. wdata(s12),.rdata1(s11),.rdata2(s10),.clk(clk));
CU   cu(.c(s4),.regdst(c1),.jump(c2),.regwr(c3),.alusrc(c4),.memrd(c5),.memwr(c6),.aluop(c7),.memtoreg(c8),.branch(c9),.bne(c14));
endmodule

