module DataMem (input [31:0]Address1,Address2,WriteData1,WriteData2,input MemRead,MemWrite,inout [31:0]Data1,Data2);
  reg [7:0] mem [0:63];
  initial begin
    mem[0]=8'b 00000000;
    mem[1]=8'b 00000001;
    mem[2]=8'b 00000010;
    mem[3]=8'b 00000011;
    mem[4]=8'b 00000000;
    mem[5]=8'b 00000000;
    mem[6]=8'b 00000000;
    mem[7]=8'b 00000100;
    mem[8]=8'b 00000000;
    mem[9]=8'b 00000000;
    mem[10]=8'b 00000000;
    mem[11]=8'b 00001100;
    mem[12]=8'b 00001100;
    mem[13]=8'b 00001101;
    mem[14]=8'b 00001110;
    mem[15]=8'b 00001111;
    mem[16]=8'b 00010000;
    mem[17]=8'b 00010001;
    mem[18]=8'b 00010010;
    mem[19]=8'b 00010011;
    mem[20]=8'b 00010100;
    mem[21]=8'b 00010101;
    mem[22]=8'b 00010110;
    mem[23]=8'b 00010111;
    mem[24]=8'b 00100000;
    mem[25]=8'b 00100001;
    mem[26]=8'b 00100010;
    mem[27]=8'b 00100011;
    mem[28]=8'b 00100100;
    mem[29]=8'b 00100101;
    mem[30]=8'b 00100110;
    mem[31]=8'b 00100111;
    mem[32]=8'b 00101000;
    mem[33]=8'b 00101001;
    mem[34]=8'b 00101010;
    mem[35]=8'b 00101011;
    mem[36]=8'b 00101100;
    mem[37]=8'b 00000101;
    mem[38]=8'b 00000110;
    mem[39]=8'b 00000111;
    mem[40]=8'b 00000000;
    mem[41]=8'b 00000001;
    mem[42]=8'b 00000010;
    mem[43]=8'b 00000011;
    mem[44]=8'b 00000100;
    mem[45]=8'b 00000101;
    mem[46]=8'b 00000110;
    mem[47]=8'b 00000111;
    mem[48]=8'b 00000000;
    mem[49]=8'b 00000001;
    mem[50]=8'b 00000010;
    mem[51]=8'b 00000011;
    mem[52]=8'b 00000100;
    mem[53]=8'b 00000101;
    mem[54]=8'b 00000110;
    mem[55]=8'b 00000111;
    mem[56]=8'b 00000000;
    mem[57]=8'b 00000001;
    mem[58]=8'b 00000010;
    mem[59]=8'b 00000011;
    mem[60]=8'b 00000100;
    mem[61]=8'b 00000101;
    mem[62]=8'b 00000110;
    mem[63]=8'b 00000111;
end
wire [31:0]address11,address12,address13,address21,address22,address23;
wire co,ov;
CSA_32bit f1 (Address1,32'b00000000000000000000000000000001,1'b0,address11,co,ov),
          f2 (Address1,32'b00000000000000000000000000000010,1'b0,address12,co,ov),
          f3 (Address1,32'b00000000000000000000000000000011,1'b0,address13,co,ov),
          f4 (Address2,32'b00000000000000000000000000000001,1'b0,address21,co,ov),
          f5 (Address2,32'b00000000000000000000000000000010,1'b0,address22,co,ov),
          f6 (Address2,32'b00000000000000000000000000000011,1'b0,address23,co,ov);
assign Data1[31:24]=MemRead ? mem[Address1]:8'b zzzzzzzz;
assign Data1[23:16]=MemRead ? mem[address11]:8'b zzzzzzzz;
assign Data1[15:8]=MemRead ? mem[address12]:8'b zzzzzzzz;
assign Data1[7:0]=MemRead ? mem[address13]:8'b zzzzzzzz;
assign Data2[31:24]=MemRead ? mem[Address2]:8'b zzzzzzzz;
assign Data2[23:16]=MemRead ? mem[address21]:8'b zzzzzzzz;
assign Data2[15:8]=MemRead ? mem[address22]:8'b zzzzzzzz;
assign Data2[7:0]=MemRead ? mem[address23]:8'b zzzzzzzz;
always @ (MemWrite,WriteData1,WriteData2) begin
if (MemWrite) begin 
mem[Address1]=WriteData1[31:24];
mem[address11]=WriteData1[23:16];
mem[address12]=WriteData1[15:8];
mem[address13]=WriteData1[7:0];
mem[Address2]=WriteData2[31:24];
mem[address21]=WriteData2[23:16];
mem[address22]=WriteData2[15:8];
mem[address23]=WriteData2[7:0];
end
end
endmodule
////////////////////////////////////
module Project_test1 (input [31:0]Address1,Address2,WriteData1,WriteData2,input select,MemRead,MemWrite,inout [31:0]Data1,Data2);
reg [31:0] rData1,rData2;
wire [31:0] WrData1,WrData2;
mux_2x32 m1 (WriteData2,rData1,select,WrData2),
         m2 (WriteData1,rData2,select,WrData1);  
DataMem DM1 (Address1,Address2,WrData1,WrData2,MemRead,MemWrite,Data1,Data2);
always@( Address1,Address2 ) begin
rData1 <= Data1;
rData2 <= Data2;
end
endmodule