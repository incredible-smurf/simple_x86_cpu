module clk_cu(input [31:0]a,input clk, output iord,output irwr,output pcwr,output pcwrcond,output regdst,output regwr,output alusrca,output[1:0]pcsrc,output [5:0]aluop,
              output [1:0]alusrcb,output memtoreg,output memrd,output memwr);

 parameter   //SPECIAL OP LIST   5-0
                ADDU    =   6'b100001,
                SUBU    =   6'b100011,
                ADD     =   6'b100000,
                SUB     =   6'b100010,
                AND     =   6'b100100,
                OR      =   6'b100101,
                XOR     =   6'b100110,
                NOR     =   6'b100111,
                SLT     =   6'b101010,
                SLTU    =   6'b101011,
                SRL     =   6'b000010,
                SRA     =   6'b000011,
                SLL     =   6'b000000,
                SLLV    =   6'b000100,
                SRLV    =   6'b000110,
                SRAV    =   6'b000111,
                JR      =   6'b001000,
                JALR    =   6'b001001,
                MULT    =    6'b011000,
                MULTU   =   6'b011001,
                DIV     =   6'b011010,
                DIVU    =   6'b011011,
                MFHI    =   6'b010000,
                MFLO    =   6'b010010,
                MTHI    =   6'b010001,
                MTLO    =   6'b010011,
                BREAK   =   6'b001101,
                SYSCALL =   6'b001100,
                TEQ     =   6'b110100,
                //SPECIAL 2 func
                CLZ        =   6'b100000,
                MUL        =   6'b000010,
                //REGIMM OP LIST 20-16
                BLTZ    =   5'b00000,
                BGEZ    =   5'b00001,
                //COP0 OP LIST 
                ERET    =   6'b011000,  //5-0&&25TH=1
                MFC0    =   5'b00000,   //20-16
                MTC0    =   5'b00100,
                //OPCODE FIELD  31-26
                ADDI    =   6'b001000,
                ADDIU   =   6'b001001,
                ANDI    =   6'b001100,
                ORI     =   6'b001101,
                XORI    =   6'b001110,
                LW      =   6'b100011,
                SW      =   6'b101011,
                BEQ     =   6'b000100,
                BNE     =   6'b000101,
                BLEZ    =   6'b000110,
                BGTZ    =   6'b000111,
                SLTI    =   6'b001010,
                SLTIU   =   6'b001011,
                LUI     =   6'b001111,
                J       =   6'b000010,
                JAL     =   6'b000011,
                LB      =   6'b100000,//    Load Byte Function=6'h24    
                LBU     =   6'b100100,//    1Load Byte Unsigned 
                LH      =   6'b100001,//    Load high 
                LHU     =   6'b100101,//    Load High Unsigned
                SB      =   6'b101000,//    Send Byte
                SH      =   6'b101001,//    Send High
                
                SPECIAL =   6'b000000,
                SPECIAL2=    6'b011100,
                REGIMM  =   6'b000001,
                COP0    =   6'b010000; 
   //alu 
    parameter   _ADDU   =   4'b0000;    //r=a+b unsigned
    parameter   _ADD    =   4'b0010;    //r=a+b signed
    parameter   _SUBU   =   4'b0001;    //r=a-b unsigned
    parameter   _SUB    =   4'b0011;    //r=a-b signed
    parameter   _AND    =   4'b0100;    //r=a&b
    parameter   _OR     =   4'b0101;    //r=a|b
    parameter   _XOR    =   4'b0110;    //r=a^b
    parameter   _NOR    =   4'b0111;    //r=~(a|b)
    
    parameter   _LUI    =   4'b1000;    //r={b[15:0],16'b0}
    parameter   _SLT    =   4'b1011;    //r=(a-b<0)?1:0 signed
    parameter   _SLTU   =   4'b1010;    //r=(a-b<0)?1:0 unsigned
    parameter   _SRA    =   4'b1100;    //r=b>>>a 
    parameter   _SLL    =   4'b1110;    //r=b<<a
    parameter   _SRL    =   4'b1101;    //r=b>>a
    parameter   _DIVU   = 6'b010000;
    parameter   _MULTU   = 6'b010001;   
    parameter    _SYSCALL=   4'b1000,
                _BREAK    =   4'b1001,
                _TEQ    =   4'b1101;

reg c1,c2,c3,c4,c5,c6,c7,c11,c12,c13;
reg[1:0]c8;
reg[1:0]c10;
reg[3:0]c9;
reg [5:0]code,codesuan;
reg [31:0]i;
reg [31:0]aimcircle;
reg suanshu;
initial
begin
c1=0;c3=1;c2=1;c7=0;c10=1;c9=_ADDU;c8=0; code=0;c12=1;c13=0;//1th
i=0;
aimcircle=3;
end

always@(posedge clk)
begin

if(i<aimcircle)
begin
 case(i)
  0:
   begin
   //code[5:0]=a[31:26];
   //codesuan[5:0]=a[5:0];
   i=i+1;
   c7=0;c10=3;c9=_ADDU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c12=0;
   end
  1:
   begin
   i=i+1;
   if (suanshu==0)
    case(code)
    LW:begin c7=1;c10=2;c9=_ADDU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SW:begin c7=1;c10=2;c9=_ADDU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end


    ADDI:begin c7=1;c10=2;c9=_ADD; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    ANDI:begin c7=1;c10=2;c9=_AND; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    ORI:begin c7=1;c10=2;c9=_OR; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    XORI:begin c7=1;c10=2;c9=_XOR; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SLTI:begin c7=1;c10=2;c9=_SLT; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SLTIU:begin c7=1;c10=2;c9=_SLTU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    ADDIU:begin c7=1;c10=2;c9=_ADDU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    BEQ:begin c7=1;c10=0;c9=_ADDU; c1=0;c2=0;c3=0;c4=1;c5=0;c6=0;c8=1;c11=0;c12=0;c13=0;end
    J:begin c7=1;c10=0;c9=_ADDU; c1=0;c2=0;c3=1;c4=0;c5=0;c6=0;c8=2;c11=0;c12=0;c13=0;end
    endcase
   else
    case(codesuan)
    ADD:begin c7=1;c10=0;c9=_ADD; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SUB:begin c7=1;c10=0;c9=_SUB; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    ADDU:begin c7=1;c10=0;c9=_ADDU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    AND:begin c7=1;c10=0;c9=_AND; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    OR:begin c7=1;c10=0;c9=_OR; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SLT:begin c7=1;c10=0;c9=_SLT; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    XOR:begin c7=1;c10=0;c9=_XOR; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    NOR:begin c7=1;c10=0;c9=_NOR; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SLTU:begin c7=1;c10=0;c9=_SLTU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SRAV:begin c7=1;c10=0;c9=_SRA; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SLLV:begin c7=1;c10=0;c9=_SLL; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SRLV:begin c7=1;c10=0;c9=_SRL; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    DIVU:begin c7=1;c10=0;c9=_DIVU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    MULTU:begin c7=1;c10=0;c9=_MULTU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    SUBU:begin c7=1;c10=0;c9=_SUBU; c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c8=0;c11=0;c12=0;c13=0;end
    endcase
   end
  2:
    begin
    i=i+1;
    if(suanshu==0)
    case(code)
      LW:begin  c1=1;c2=0;c3=0;c4=0;c5=0;c6=0;c7=0;c8=0;c9=_ADDU;c10=0;c11=0;c12=1;c13=0;end
      SW:begin  c1=1;c2=0;c3=0;c4=0;c5=0;c6=0;c7=0;c8=0;c9=_ADDU;c10=0;c11=0;c12=0;c13=1;end
    ADDIU,SLTIU, SLTI,XORI, ORI,ANDI,ADDI:begin  c1=0;c2=0;c3=0;c4=0;c5=0;c6=1;c7=0;c8=0;c9=_ADDU;c10=0;c11=0;c12=0;c13=0;end
    endcase
    else
    case(codesuan)
    SUBU,MULTU,DIVU,SRLV,SLLV,SRAV,SLTU,NOR,XOR,SLT,OR,AND,ADDU,SUB,ADD:begin  c1=0;c2=0;c3=0;c4=0;c5=1;c6=1;c7=0;c8=0;c9=_ADDU;c10=0;c11=0;c12=0;c13=0;end
    endcase
    end
  3:
    begin
    i=i+1;
    if (suanshu==0)
    case(code)
    LW:begin  c1=0;c2=0;c3=0;c4=0;c5=0;c6=1;c7=0;c8=0;c9=_ADDU;c10=0;c11=1;c12=0;c13=0;end
    endcase
    end
   
   
 endcase
end
else
begin
c1=0;c2=0;c3=0;c4=0;c5=0;c6=0;c7=0;c8=0;c9=0;c10=0;c11=0;c12=0;c13=0;
c1=0;c3=1;c2=1;c7=0;c10=1;c9=_ADDU;c8=0; code=0;c12=1;c13=0;//1th
i=0;

end
end


always@(a)
begin
suanshu=0;
code[5:0]=a[31:26];
codesuan[5:0]=a[5:0];
   if (code==0)
    begin
    suanshu=1;
    end

   case (code)
   LW:aimcircle=4;
   SW:aimcircle=3;
   0:aimcircle=3;
   BEQ:aimcircle=2;
   J:aimcircle=2;
   ADDI,ANDI,ORI,XORI,SLTI,SLTIU,ADDIU:aimcircle=3;
   endcase
end
assign iord=c1;
assign irwr=c2;
assign pcwr=c3;
assign pcwrcond=c4;
assign regdst=c5;
assign regwr=c6;
assign alusrca=c7;
assign pcsrc=c8;
assign aluop=c9;
assign alusrcb=c10;
assign memtoreg=c11;
assign memrd=c12;
assign memwr=c13;
endmodule


