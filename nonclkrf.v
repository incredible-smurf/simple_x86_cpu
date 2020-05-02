module nonclkRF(
        input rst,
        input we,
        input [4:0] raddr1,
        input [4:0] raddr2,
        input [4:0] waddr,
        input [31:0] wdata,
        output [31:0] rdata1,
        output [31:0] rdata2
        );
   
    reg [31:0] data [0:31];
    reg [8:0] i;
    reg [31:0] a1,a2;

    initial
    begin
    a1=0;
    a2=0;
    for(i=0;i<32;i=i+1) 
     begin
            data[i]=i;
        end
    end

    always@(*) 
    begin
        if(rst)  for(i=0;i<32;i=i+1) begin
            data[i]<=32'b0;
        end
        else begin
            if(we) data[waddr]<=wdata;
        end
        a1=data[raddr1];
        a2=data[raddr2];
    end
    assign rdata1=a1;
    assign rdata2=a2;
endmodule
