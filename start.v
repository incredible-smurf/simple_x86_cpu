module all;
wire [31:0] s1,s2;
reg clk,rst,ena_pc;

initial
   begin
clk=0;
rst=1;
#100 rst=0;
   end

 always #50 clk=~clk;

PC pc1(.clk(clk),.rst(rst),.ena(ena_pc),.data_in(s2),.data_out(s1));

endmodule
