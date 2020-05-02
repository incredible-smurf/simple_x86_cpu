module ram(//IM&&RAM
        input wena,
        input rena,
        input clk,
        input [31:0] order,
        input [31:0] addr,
        input [31:0] data_in,
        output [31:0] data_out
        );
    reg [31:0]i;    
    reg [31:0] state [0:10000];
    reg [31:0] whichtoshow;
    reg [5:0]writenumber;
     initial
     begin
     whichtoshow=32'b0;
     end
                parameter
                SB      =   6'b101000,//    Send Byte
                SH      =   6'b101001;// 

initial
begin
for(i=0;i<255;i=i+1)
begin
state[i]=32'h00000000;
$readmemb("F:/dan",state);
end
state[200]=999;
end


    always   @(addr)
    begin
         if(rena)
         whichtoshow=state[addr];
         else
         whichtoshow=32'bz;
    end 
    always@(posedge clk)
        if(wena) 
        begin
            if(addr!=0) 
            case(writenumber)
SB:state[addr][7:0]<=data_in[7:0];
SH:state[addr][15:0]<=data_in[15:0];
default:state[addr]<=data_in;
            endcase
        end
assign data_out=whichtoshow;
    always@(order)
    begin
     writenumber[5:0]=order[31:26];
     end
endmodule
