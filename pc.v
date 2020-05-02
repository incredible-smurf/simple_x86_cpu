module pca(
    input clk,//??
    input rst,//??
    input [31:0] data_in,
    output [31:0] data_out
    );
    
    reg [31:0] data;

initial
data=0;
    always @(posedge clk) begin
        if(rst) data<=32'h00000000;        //reset key
        else begin
             data<=data_in;        //enable ,input 
        end
    end
    
    assign data_out    =   data;
    
endmodule
