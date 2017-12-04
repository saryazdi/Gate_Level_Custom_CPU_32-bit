module tristate_buffer(input x, enable, output z);
assign z = enable? x : 'bz;
endmodule
//////////////////////////////////////////////////
module reg_32bit (input[31:0] d, input en,wr,clk, output[31:0] q);
reg[31:0] internal_q;
always@( posedge clk ) begin
  if (en) begin
if (wr) internal_q <= d;
end
end
assign q = internal_q;
endmodule
//////////////////////////////////////////////////
module decoder_32bit (input [4:0]x, output [31:0]y);
and(y[0],~x[4],~x[3],~x[2],~x[1],~x[0]);
and(y[1],~x[4],~x[3],~x[2],~x[1],x[0]);
and(y[2],~x[4],~x[3],~x[2],x[1],~x[0]);
and(y[3],~x[4],~x[3],~x[2],x[1],x[0]);
and(y[4],~x[4],~x[3],x[2],~x[1],~x[0]);
and(y[5],~x[4],~x[3],x[2],~x[1],x[0]);
and(y[6],~x[4],~x[3],x[2],x[1],~x[0]);
and(y[7],~x[4],~x[3],x[2],x[1],x[0]);
and(y[8],~x[4],x[3],~x[2],~x[1],~x[0]);
and(y[9],~x[4],x[3],~x[2],~x[1],x[0]);
and(y[10],~x[4],x[3],~x[2],x[1],~x[0]);
and(y[11],~x[4],x[3],~x[2],x[1],x[0]);
and(y[12],~x[4],x[3],x[2],~x[1],~x[0]);
and(y[13],~x[4],x[3],x[2],~x[1],x[0]);
and(y[14],~x[4],x[3],x[2],x[1],~x[0]);
and(y[15],~x[4],x[3],x[2],x[1],x[0]);
and(y[16],x[4],~x[3],~x[2],~x[1],~x[0]);
and(y[17],x[4],~x[3],~x[2],~x[1],x[0]);
and(y[18],x[4],~x[3],~x[2],x[1],~x[0]);
and(y[19],x[4],~x[3],~x[2],x[1],x[0]);
and(y[20],x[4],~x[3],x[2],~x[1],~x[0]);
and(y[21],x[4],~x[3],x[2],~x[1],x[0]);
and(y[22],x[4],~x[3],x[2],x[1],~x[0]);
and(y[23],x[4],~x[3],x[2],x[1],x[0]);
and(y[24],x[4],x[3],~x[2],~x[1],~x[0]);
and(y[25],x[4],x[3],~x[2],~x[1],x[0]);
and(y[26],x[4],x[3],~x[2],x[1],~x[0]);
and(y[27],x[4],x[3],~x[2],x[1],x[0]);
and(y[28],x[4],x[3],x[2],~x[1],~x[0]);
and(y[29],x[4],x[3],x[2],~x[1],x[0]);
and(y[30],x[4],x[3],x[2],x[1],~x[0]);
and(y[31],x[4],x[3],x[2],x[1],x[0]);
endmodule
//////////////////////////////////////////
module mux_2x5 (input [4:0]O1,O2, input select, output [4:0]out1);
mux m1 (O1[0],O2[0],select,out1[0]),
    m2 (O1[1],O2[1],select,out1[1]),
    m3 (O1[2],O2[2],select,out1[2]),
    m4 (O1[3],O2[3],select,out1[3]),
    m5 (O1[4],O2[4],select,out1[4]);
  endmodule
  //////////////////////////////////////////
   module mux_4x5 (input [4:0]O1,O2,O3,O4, input [1:0]select, output [4:0]out3);
  wire [4:0]out1,out2;
mux q1 (O1[0],O2[0],select[0],out1[0]),
    q2 (O1[1],O2[1],select[0],out1[1]),
    q3 (O1[2],O2[2],select[0],out1[2]),
    q4 (O1[3],O2[3],select[0],out1[3]),
    q5 (O1[4],O2[4],select[0],out1[4]),
    r1 (O3[0],O4[0],select[0],out2[0]),
    r2 (O3[1],O4[1],select[0],out2[1]),
    r3 (O3[2],O4[2],select[0],out2[2]),
    r4 (O3[3],O4[3],select[0],out2[3]),
    r5 (O3[4],O4[4],select[0],out2[4]),
    t1 (out1[0],out2[0],select[1],out3[0]),
    t2 (out1[1],out2[1],select[1],out3[1]),
    t3 (out1[2],out2[2],select[1],out3[2]),
    t4 (out1[3],out2[3],select[1],out3[3]),
    t5 (out1[4],out2[4],select[1],out3[4]);
  endmodule
//////////////////////////////////////////
module mux_2x32 (input [31:0]O1,O2, input select, output [31:0]out1);
mux m1 (O1[0],O2[0],select,out1[0]),
    m2 (O1[1],O2[1],select,out1[1]),
    m3 (O1[2],O2[2],select,out1[2]),
    m4 (O1[3],O2[3],select,out1[3]),
    m5 (O1[4],O2[4],select,out1[4]),
    m6 (O1[5],O2[5],select,out1[5]),
    m7 (O1[6],O2[6],select,out1[6]),
    m8 (O1[7],O2[7],select,out1[7]),
    m9 (O1[8],O2[8],select,out1[8]),
    m10 (O1[9],O2[9],select,out1[9]),
    m11 (O1[10],O2[10],select,out1[10]),
    m12 (O1[11],O2[11],select,out1[11]),
    m13 (O1[12],O2[12],select,out1[12]),
    m14 (O1[13],O2[13],select,out1[13]),
    m15 (O1[14],O2[14],select,out1[14]),
    m16 (O1[15],O2[15],select,out1[15]),
    m17 (O1[16],O2[16],select,out1[16]),
    m18 (O1[17],O2[17],select,out1[17]),
    m19 (O1[18],O2[18],select,out1[18]),
    m20 (O1[19],O2[19],select,out1[19]),
    m21 (O1[20],O2[20],select,out1[20]),
    m22 (O1[21],O2[21],select,out1[21]),
    m23 (O1[22],O2[22],select,out1[22]),
    m24 (O1[23],O2[23],select,out1[23]),
    m25 (O1[24],O2[24],select,out1[24]),
    m26 (O1[25],O2[25],select,out1[25]),
    m27 (O1[26],O2[26],select,out1[26]),
    m28 (O1[27],O2[27],select,out1[27]),
    m29 (O1[28],O2[28],select,out1[28]),
    m30 (O1[29],O2[29],select,out1[29]),
    m31 (O1[30],O2[30],select,out1[30]),
    m32 (O1[31],O2[31],select,out1[31]);
  endmodule
  ///////////////////////////////////////////////
  module mux_4x32 (input [31:0]O1,O2,O3,O4, input [1:0]select, output [31:0]out3);
  wire [31:0]out1,out2;
mux m1 (O1[0],O2[0],select[0],out1[0]),
    m2 (O1[1],O2[1],select[0],out1[1]),
    m3 (O1[2],O2[2],select[0],out1[2]),
    m4 (O1[3],O2[3],select[0],out1[3]),
    m5 (O1[4],O2[4],select[0],out1[4]),
    m6 (O1[5],O2[5],select[0],out1[5]),
    m7 (O1[6],O2[6],select[0],out1[6]),
    m8 (O1[7],O2[7],select[0],out1[7]),
    m9 (O1[8],O2[8],select[0],out1[8]),
    m10 (O1[9],O2[9],select[0],out1[9]),
    m11 (O1[10],O2[10],select[0],out1[10]),
    m12 (O1[11],O2[11],select[0],out1[11]),
    m13 (O1[12],O2[12],select[0],out1[12]),
    m14 (O1[13],O2[13],select[0],out1[13]),
    m15 (O1[14],O2[14],select[0],out1[14]),
    m16 (O1[15],O2[15],select[0],out1[15]),
    m17 (O1[16],O2[16],select[0],out1[16]),
    m18 (O1[17],O2[17],select[0],out1[17]),
    m19 (O1[18],O2[18],select[0],out1[18]),
    m20 (O1[19],O2[19],select[0],out1[19]),
    m21 (O1[20],O2[20],select[0],out1[20]),
    m22 (O1[21],O2[21],select[0],out1[21]),
    m23 (O1[22],O2[22],select[0],out1[22]),
    m24 (O1[23],O2[23],select[0],out1[23]),
    m25 (O1[24],O2[24],select[0],out1[24]),
    m26 (O1[25],O2[25],select[0],out1[25]),
    m27 (O1[26],O2[26],select[0],out1[26]),
    m28 (O1[27],O2[27],select[0],out1[27]),
    m29 (O1[28],O2[28],select[0],out1[28]),
    m30 (O1[29],O2[29],select[0],out1[29]),
    m31 (O1[30],O2[30],select[0],out1[30]),
    m32 (O1[31],O2[31],select[0],out1[31]),
    n1 (O3[0],O4[0],select[0],out2[0]),
    n2 (O3[1],O4[1],select[0],out2[1]),
    n3 (O3[2],O4[2],select[0],out2[2]),
    n4 (O3[3],O4[3],select[0],out2[3]),
    n5 (O3[4],O4[4],select[0],out2[4]),
    n6 (O3[5],O4[5],select[0],out2[5]),
    n7 (O3[6],O4[6],select[0],out2[6]),
    n8 (O3[7],O4[7],select[0],out2[7]),
    n9 (O3[8],O4[8],select[0],out2[8]),
    n10 (O3[9],O4[9],select[0],out2[9]),
    n11 (O3[10],O4[10],select[0],out2[10]),
    n12 (O3[11],O4[11],select[0],out2[11]),
    n13 (O3[12],O4[12],select[0],out2[12]),
    n14 (O3[13],O4[13],select[0],out2[13]),
    n15 (O3[14],O4[14],select[0],out2[14]),
    n16 (O3[15],O4[15],select[0],out2[15]),
    n17 (O3[16],O4[16],select[0],out2[16]),
    n18 (O3[17],O4[17],select[0],out2[17]),
    n19 (O3[18],O4[18],select[0],out2[18]),
    n20 (O3[19],O4[19],select[0],out2[19]),
    n21 (O3[20],O4[20],select[0],out2[20]),
    n22 (O3[21],O4[21],select[0],out2[21]),
    n23 (O3[22],O4[22],select[0],out2[22]),
    n24 (O3[23],O4[23],select[0],out2[23]),
    n25 (O3[24],O4[24],select[0],out2[24]),
    n26 (O3[25],O4[25],select[0],out2[25]),
    n27 (O3[26],O4[26],select[0],out2[26]),
    n28 (O3[27],O4[27],select[0],out2[27]),
    n29 (O3[28],O4[28],select[0],out2[28]),
    n30 (O3[29],O4[29],select[0],out2[29]),
    n31 (O3[30],O4[30],select[0],out2[30]),
    n32 (O3[31],O4[31],select[0],out2[31]),
    p1 (out1[0],out2[0],select[1],out3[0]),
    p2 (out1[1],out2[1],select[1],out3[1]),
    p3 (out1[2],out2[2],select[1],out3[2]),
    p4 (out1[3],out2[3],select[1],out3[3]),
    p5 (out1[4],out2[4],select[1],out3[4]),
    p6 (out1[5],out2[5],select[1],out3[5]),
    p7 (out1[6],out2[6],select[1],out3[6]),
    p8 (out1[7],out2[7],select[1],out3[7]),
    p9 (out1[8],out2[8],select[1],out3[8]),
    p10 (out1[9],out2[9],select[1],out3[9]),
    p11 (out1[10],out2[10],select[1],out3[10]),
    p12 (out1[11],out2[11],select[1],out3[11]),
    p13 (out1[12],out2[12],select[1],out3[12]),
    p14 (out1[13],out2[13],select[1],out3[13]),
    p15 (out1[14],out2[14],select[1],out3[14]),
    p16 (out1[15],out2[15],select[1],out3[15]),
    p17 (out1[16],out2[16],select[1],out3[16]),
    p18 (out1[17],out2[17],select[1],out3[17]),
    p19 (out1[18],out2[18],select[1],out3[18]),
    p20 (out1[19],out2[19],select[1],out3[19]),
    p21 (out1[20],out2[20],select[1],out3[20]),
    p22 (out1[21],out2[21],select[1],out3[21]),
    p23 (out1[22],out2[22],select[1],out3[22]),
    p24 (out1[23],out2[23],select[1],out3[23]),
    p25 (out1[24],out2[24],select[1],out3[24]),
    p26 (out1[25],out2[25],select[1],out3[25]),
    p27 (out1[26],out2[26],select[1],out3[26]),
    p28 (out1[27],out2[27],select[1],out3[27]),
    p29 (out1[28],out2[28],select[1],out3[28]),
    p30 (out1[29],out2[29],select[1],out3[29]),
    p31 (out1[30],out2[30],select[1],out3[30]),
    p32 (out1[31],out2[31],select[1],out3[31]);
  endmodule
  ///////////////////////////////////////////////
module Latch_1bit (input D, input clk, output reg Q); 
always @ (posedge clk) 
    begin 
       Q <= D; 
   end 
endmodule 
/////////////////////////////////////////
module Latch_32bit (input [31:0]D,input clk,output [31:0]Q);
Latch_1bit L0 (D[0],clk,Q[0]),
           L1 (D[1],clk,Q[1]),
           L2 (D[2],clk,Q[2]),
           L3 (D[3],clk,Q[3]),
           L4 (D[4],clk,Q[4]),
           L5 (D[5],clk,Q[5]),
           L6 (D[6],clk,Q[6]),
           L7 (D[7],clk,Q[7]),
           L8 (D[8],clk,Q[8]),
           L9 (D[9],clk,Q[9]),
           L10 (D[10],clk,Q[10]),
           L11 (D[11],clk,Q[11]),
           L12 (D[12],clk,Q[12]),
           L13 (D[13],clk,Q[13]),
           L14 (D[14],clk,Q[14]),
           L15 (D[15],clk,Q[15]),
           L16 (D[16],clk,Q[16]),
           L17 (D[17],clk,Q[17]),
           L18 (D[18],clk,Q[18]),
           L19 (D[19],clk,Q[19]),
           L20 (D[20],clk,Q[20]),
           L21 (D[21],clk,Q[21]),
           L22 (D[22],clk,Q[22]),
           L23 (D[23],clk,Q[23]),
           L24 (D[24],clk,Q[24]),
           L25 (D[25],clk,Q[25]),
           L26 (D[26],clk,Q[26]),
           L27 (D[27],clk,Q[27]),
           L28 (D[28],clk,Q[28]),
           L29 (D[29],clk,Q[29]),
           L30 (D[30],clk,Q[30]),
           L31 (D[31],clk,Q[31]);
endmodule
/////////////////////////////////////////
module SignExtend16 (input [15:0]x, output [31:0]y);
  assign y[15:0]=x[15:0];
  assign y[16]=x[15];
  assign y[17]=x[15];
  assign y[18]=x[15];
  assign y[19]=x[15];
  assign y[20]=x[15];
  assign y[21]=x[15];
  assign y[22]=x[15];
  assign y[23]=x[15];
  assign y[24]=x[15];
  assign y[25]=x[15];
  assign y[26]=x[15];
  assign y[27]=x[15];
  assign y[28]=x[15];
  assign y[29]=x[15];
  assign y[30]=x[15];
  assign y[31]=x[15];
endmodule
/////////////////////////////////////////
module Latch_5bit (input [4:0]D,input clk,output [4:0]Q);
  Latch_1bit L0 (D[0],clk,Q[0]),
             L1 (D[1],clk,Q[1]),
             L2 (D[2],clk,Q[2]),
             L3 (D[3],clk,Q[3]),
             L4 (D[4],clk,Q[4]);
endmodule
////////////////////////////////////////
module Latch_2bit (input [1:0]D,input clk,output [1:0]Q);
  Latch_1bit L00 (D[0],clk,Q[0]),
             L01 (D[1],clk,Q[1]);
endmodule