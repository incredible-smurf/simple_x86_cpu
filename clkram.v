module clkram(//IM&&RAM
        input wena,
        input rena,
        input clk,
        input [31:0] addr,
        input [31:0] data_in,
        output [31:0] data_out
        );
reg [31:0]i;    

    reg [31:0] state [0:10000];
    reg [31:0] whichtoshow;
     initial
     begin
     whichtoshow=32'b0;
     end

initial
begin

for(i=0;i<255;i=i+1)
begin
state[i]=32'h00000000;
$readmemb("F:/duo",state);
end
state[200]=999;
end



    always   @(addr or rena)
    begin
         if(rena)
         whichtoshow=state[addr];
         else
         whichtoshow=32'bz;
    end 
    always@(posedge clk)
        if(wena) 
        begin
            if(addr!=0) state[addr]<=data_in;
        end
assign data_out=whichtoshow;
    
endmodule