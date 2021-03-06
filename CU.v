module CU(input [31:0] c,output regdst,output jump,output regwr,output bne,output branch,output memtoreg,output [5:0]aluop,output memwr,output memrd,output alusrc);
    parameter   //SPECIAL OP LIST   5-0
                ADDU    =   6'b100001,//1
                SUBU    =   6'b100011,//
                ADD     =   6'b100000,//
                SUB     =   6'b100010,//
                AND     =   6'b100100,//
                OR      =   6'b100101,//
                XOR     =   6'b100110,//
                NOR     =   6'b100111,//
                SLT     =   6'b101010,//
                SLTU    =   6'b101011,//
                SRL     =   6'b000010,//
                SRA     =   6'b000011,//
                SLL     =   6'b000000,//
                SLLV    =   6'b000100,
                SRLV    =   6'b000110,
                SRAV    =   6'b000111,
                JR      =   6'b001000,
                JALR    =   6'b001001,
                MULT    =    6'b011000,
                MULTU   =   6'b011001,
                DIV     =   6'b011010,
                DIVU    =   6'b011011,//
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
                ADDI    =   6'b001000,//
                ADDIU   =   6'b001001,//
                ANDI    =   6'b001100,//
                ORI     =   6'b001101,//
                XORI    =   6'b001110,//
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
reg c1,c2,c3,c4,c5,c6,c8,c9,c14;
reg[5:0]c7;
reg [5:0]o;
reg [5:0]mo,suanshu;
initial
begin
c14=0;
c1=0;
c2=0;
c3=0;
c4=0;
c5=0;
c6=0;
c7=0;
c8=0;
c9=0;
o=0;
end
   always @(*)
   begin
   suanshu=0;
   o[5:0]=c[31:26];
   mo[5:0]=c[5:0];
   if(o==0)
   begin
      o=mo;
      suanshu=1;
   end
   c14=0;
if(suanshu==0)
begin
c14=0;
   case(o)
LW:begin c1=0; c3=1;c4=1;c5=1;c6=0;c8=1;c9=0;c2=0;c7=_ADD;end//over
SW,SB,SH:begin c1=1; c3=0;c4=1;c5=0;c6=1;c8=1;c9=0;c2=0;c7=_ADD;end//over

BEQ:begin c1=0; c3=0;c4=0;c5=0;c6=0;c8=1;c9=1;c2=0;c7=_SUB;end
BNE:begin c1=0; c3=0;c4=0;c5=0;c6=0;c8=1;c9=0;c2=0;c7=_SUB;c14=1;end
J:begin c1=0; c3=0;c4=1;c5=0;c6=0;c8=1;c9=0;c2=1;c7=_ADD;end

ADDI:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_ADD;end//
ANDI:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_AND;end
ORI:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_OR;end
XORI:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_XOR;end
SLTI:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SLT;end
SLTIU:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SLTU;end
ADDIU:begin c1=0; c3=1;c4=1;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_ADDU;end
   endcase
end

else
begin
c14=0;
   case(o)
ADD:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_ADD;end
ADDU:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_ADDU;end
SUB:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SUB;end
AND:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_AND;end
OR:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_OR;end
SLT:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SLT;end
XOR:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_XOR;end//new
NOR:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_NOR;end
SLTU:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SLTU;end
SUBU:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SUBU;end
SRAV:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SRA;end
SLLV:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SLL;end
SRLV:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_SRL;end
DIVU:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_DIVU;end
MULTU:begin c1=1; c3=1;c4=0;c5=0;c6=0;c8=0;c9=0;c2=0;c7=_MULTU;end

   endcase
end
   end
assign regdst=c1;
assign jump=c2;
assign regwr=c3;
assign alusrc=c4;
assign memrd=c5;
assign memwr=c6;
assign aluop=c7;
assign memtoreg=c8;
assign branch=c9;
assign bne=c14;
endmodule
