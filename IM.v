module IM(
        input wena,
        input rena,
        input [31:0] addr,
        input [31:0] data_in,
        output [31:0] data_out
        );
    
    reg [31:0] state [0:4294967295];
    reg [31:0] whichtoshow;
     initial
     begin
     whichtoshow=32'bz;
     end


    always   @(addr)
    begin
        if(wena) 
        begin
            if(addr!=0) state[addr]<=data_in;
        end
         if(rena)
         whichtoshow=state[addr];
         else
         whichtoshow=32'bz;
    end 
assign data_out=whichtoshow;
    
endmodule
