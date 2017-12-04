module FA_1bit (input a,b,cin, output s,cout);
xor(o1,a,b);
xor(s,o1,cin);
and(o2,a,b);
and(o3,o1,cin);
or(cout,o2,o3);
endmodule
///////////////////////
module EN_not(input [31:0]a, input en, output [31:0]c);
  xor(c[0],a[0],en);
  xor(c[1],a[1],en);
  xor(c[2],a[2],en);
  xor(c[3],a[3],en);
  xor(c[4],a[4],en);
  xor(c[5],a[5],en);
  xor(c[6],a[6],en);
  xor(c[7],a[7],en);
  xor(c[8],a[8],en);
  xor(c[9],a[9],en);
  xor(c[10],a[10],en);
  xor(c[11],a[11],en);
  xor(c[12],a[12],en);
  xor(c[13],a[13],en);
  xor(c[14],a[14],en);
  xor(c[15],a[15],en);
  xor(c[16],a[16],en);
  xor(c[17],a[17],en);
  xor(c[18],a[18],en);
  xor(c[19],a[19],en);
  xor(c[20],a[20],en);
  xor(c[21],a[21],en);
  xor(c[22],a[22],en);
  xor(c[23],a[23],en);
  xor(c[24],a[24],en);
  xor(c[25],a[25],en);
  xor(c[26],a[26],en);
  xor(c[27],a[27],en);
  xor(c[28],a[28],en);
  xor(c[29],a[29],en);
  xor(c[30],a[30],en);
  xor(c[31],a[31],en);
endmodule
///////////////////////
module RCA_4bit (input [3:0]a,b, input cin, output [3:0]s, output cout);
  FA_1bit f1 (a[0],b[0],cin,s[0],c0),
          f2 (a[1],b[1],c0,s[1],c1),
          f3 (a[2],b[2],c1,s[2],c2),
          f4 (a[3],b[3],c2,s[3],cout);
endmodule
///////////////////////
module RCA_16bit (input [15:0]a,b, input cin, output [15:0]s, output cout);
  RCA_4bit f1 (a[3:0],b[3:0],cin,s[3:0],c0),
           f2 (a[7:4],b[7:4],c0,s[7:4],c1),
           f3 (a[11:8],b[11:8],c1,s[11:8],c2),
           f4 (a[15:12],b[15:12],c2,s[15:12],cout);
endmodule
///////////////////////
module RCA_32bit (input [31:0]a,b, input en, output [31:0]s, output cout,ovfl);
  wire [31:0]c;
  EN_not en1 (b[31:0],en,c[31:0]);
  RCA_16bit f1 (a[15:0],c[15:0],en,s[15:0],c0),
            f2 (a[31:16],c[31:16],c0,s[31:16],cout);
  wire q,x0,x1,z;
  xor(q,a[31],b[31]);
  xor(x0,q,en);
  not(x1,x0);
  xor(z,a[31],s[31]);
  and(ovfl,x1,z);
endmodule
///////////////////////
module mux (input a,b,s, output r);
  and(o1,a,~s);
  and(o2,b,s);
  or(r,o1,o2);
endmodule
///////////////////////
module CSA_2bit (input [1:0]a,b, input cin, output [1:0]s, output cout);
  FA_1bit f1 (a[0],b[0],cin,s[0],c0),
          f2 (a[1],b[1],1'b0,o1,c1),
          f3 (a[1],b[1],1'b1,o2,c2);
  mux m1 (o1,o2,c0,s[1]),
      m2 (c1,c2,c0,cout);
endmodule
///////////////////////
module CSA_4bit (input [3:0]a,b, input cin, output [3:0]s, output cout);
  wire [1:0]o1,o2;
  CSA_2bit f1 (a[1:0],b[1:0],cin,s[1:0],c0),
           f2 (a[3:2],b[3:2],1'b0,o1[1:0],c1),
           f3 (a[3:2],b[3:2],1'b1,o2[1:0],c2);
  mux m1 (o1[0],o2[0],c0,s[2]),
      m2 (o1[1],o2[1],c0,s[3]),
      m3 (c1,c2,c0,cout);
endmodule
//////////////////////
module CSA_8bit (input [7:0]a,b, input cin, output [7:0]s, output cout);
  wire [3:0]o1,o2;
  CSA_4bit f1 (a[3:0],b[3:0],cin,s[3:0],c0),
           f2 (a[7:4],b[7:4],1'b0,o1[3:0],c1),
           f3 (a[7:4],b[7:4],1'b1,o2[3:0],c2);
  mux m1 (o1[0],o2[0],c0,s[4]),
      m2 (o1[1],o2[1],c0,s[5]),
      m3 (o1[2],o2[2],c0,s[6]),
      m4 (o1[3],o2[3],c0,s[7]),
      m5 (c1,c2,c0,cout);
endmodule
//////////////////////
module CSA_16bit (input [15:0]a,b, input cin, output [15:0]s, output cout);
  wire [7:0]o1,o2;
  CSA_8bit f1 (a[7:0],b[7:0],cin,s[7:0],c0),
           f2 (a[15:8],b[15:8],1'b0,o1[7:0],c1),
           f3 (a[15:8],b[15:8],1'b1,o2[7:0],c2);
  mux m1 (o1[0],o2[0],c0,s[8]),
      m2 (o1[1],o2[1],c0,s[9]),
      m3 (o1[2],o2[2],c0,s[10]),
      m4 (o1[3],o2[3],c0,s[11]),
      m5 (o1[4],o2[4],c0,s[12]),
      m6 (o1[5],o2[5],c0,s[13]),
      m7 (o1[6],o2[6],c0,s[14]),
      m8 (o1[7],o2[7],c0,s[15]),
      m9 (c1,c2,c0,cout);
endmodule
//////////////////////
module CSA_32bit (input [31:0]a,b, input en, output [31:0]s, output cout,ovfl);
  wire [15:0]o1,o2;
  wire [31:0]c;
  EN_not en1 (b[31:0],en,c[31:0]);
  CSA_16bit f1 (a[15:0],c[15:0],en,s[15:0],c0),
           f2 (a[31:16],c[31:16],1'b0,o1[15:0],c1),
           f3 (a[31:16],c[31:16],1'b1,o2[15:0],c2);
  mux m1 (o1[0],o2[0],c0,s[16]),
      m2 (o1[1],o2[1],c0,s[17]),
      m3 (o1[2],o2[2],c0,s[18]),
      m4 (o1[3],o2[3],c0,s[19]),
      m5 (o1[4],o2[4],c0,s[20]),
      m6 (o1[5],o2[5],c0,s[21]),
      m7 (o1[6],o2[6],c0,s[22]),
      m8 (o1[7],o2[7],c0,s[23]),
      m9 (o1[8],o2[8],c0,s[24]),
      m10 (o1[9],o2[9],c0,s[25]),
      m11 (o1[10],o2[10],c0,s[26]),
      m12 (o1[11],o2[11],c0,s[27]),
      m13 (o1[12],o2[12],c0,s[28]),
      m14 (o1[13],o2[13],c0,s[29]),
      m15 (o1[14],o2[14],c0,s[30]),
      m16 (o1[15],o2[15],c0,s[31]),
      m17 (c1,c2,c0,cout);
  wire q,x0,x1,z;
  xor(q,a[31],b[31]);
  xor(x0,q,en);
  not(x1,x0);
  xor(z,a[31],s[31]);
  and(ovfl,x1,z);
endmodule
/////////////////////
module PG_FA (input a,b,cin, output s,p,g);
xor(p,a,b);
xor(s,p,cin);
and(g,a,b);
endmodule
/////////////////////
module CLA_4bit (input [3:0]a,b, input cin, output[3:0]s, output cout,pg,gg);
  wire [3:0]p,g;
  assign c1=g[0]+(p[0]&cin);
  assign c2=g[1]+(g[0]&p[1])+(cin&p[0]&p[1]);
  assign c3=g[2]+(g[1]&p[2])+(g[0]&p[1]&p[2])+(cin&p[0]&p[1]&p[2]);
  assign cout=g[3]+(g[2]&p[3])+(g[1]&p[2]&p[3])+(g[0]&p[1]&p[2]&p[3])+(cin&p[0]&p[1]&p[2]&p[3]);
  assign pg=p[3]&p[2]&p[1]&p[0];
  assign gg=g[3]+(p[3]&g[2])+(p[3]&p[2]&g[1])+(p[3]&p[2]&p[1]&g[0]);
  PG_FA f1 (a[0],b[0],cin,s[0],p[0],g[0]),
        f2 (a[1],b[1],c1,s[1],p[1],g[1]),
        f3 (a[2],b[2],c2,s[2],p[2],g[2]),
        f4 (a[3],b[3],c3,s[3],p[3],g[3]);
endmodule
////////////////////
module CLA_16bit (input [15:0]a,b, input cin, output[15:0]s, output cout,pg,gg);
  wire [3:0]p,g;
  assign c1=g[0]+(p[0]&cin);
  assign c2=g[1]+(g[0]&p[1])+(cin&p[0]&p[1]);
  assign c3=g[2]+(g[1]&p[2])+(g[0]&p[1]&p[2])+(cin&p[0]&p[1]&p[2]);
  assign cout=g[3]+(g[2]&p[3])+(g[1]&p[2]&p[3])+(g[0]&p[1]&p[2]&p[3])+(cin&p[0]&p[1]&p[2]&p[3]);
  assign pg=p[3]&p[2]&p[1]&p[0];
  assign gg=g[3]+(p[3]&g[2])+(p[3]&p[2]&g[1])+(p[3]&p[2]&p[1]&g[0]);
  CLA_4bit f1 (a[3:0],b[3:0],cin,s[3:0],co0,p[0],g[0]),
           f2 (a[7:4],b[7:4],c1,s[7:4],co1,p[1],g[1]),
           f3 (a[11:8],b[11:8],c2,s[11:8],co2,p[2],g[2]),
           f4 (a[15:12],b[15:12],c3,s[15:12],co3,p[3],g[3]);
endmodule
/////////////////////
module CLA_32bit (input [31:0]a,b, input en, output[31:0]s, output cout,ovfl);
  wire [1:0]p,g;
  wire [31:0]c;
  EN_not en1 (b[31:0],en,c[31:0]);
  assign c1=g[0]+(p[0]&en);
  assign cout=g[1]+(g[0]&p[1])+(en&p[0]&p[1]);
  CLA_16bit f1 (a[15:0],c[15:0],en,s[15:0],co0,p[0],g[0]),
            f2 (a[31:16],c[31:16],c1,s[31:16],co1,p[1],g[1]);
  wire q,x0,x1,z;
  xor(q,a[31],b[31]);
  xor(x0,q,en);
  not(x1,x0);
  xor(z,a[31],s[31]);
  and(ovfl,x1,z);
endmodule
/////////////////////
module ShiftRLogical1 (input [31:0]a, output [31:0]s, output cout,ovfl);
assign s[31]=1'b0;
assign s[30:0]=a[31:1];
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
////////////////////
module ShiftRLogical2 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftRLogical1 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftRLogical4 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftRLogical2 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftRLogical8 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftRLogical4 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftRLogical16 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftRLogical8 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
/////////////////////
module ShiftLLogical1 (input [31:0]a, output [31:0]s, output cout,ovfl);
assign s[0]=1'b0;
assign s[31:1]=a[30:0];
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
////////////////////
module ShiftLLogical2 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftLLogical1 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
endmodule
///////////////////
module ShiftLLogical4 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftLLogical2 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftLLogical8 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftLLogical4 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftLLogical16 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,o,p;
ShiftLLogical8 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],o,p);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftLArithmetic1 (input [31:0]a, output [31:0]s, output cout,ovfl);
assign s[0]=1'b0;
assign s[31:1]=a[30:0];
xor(ovfl,a[31],a[30]);
assign cout=1'b0;
endmodule
////////////////////
module ShiftLArithmetic2 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
assign cout=1'b0;
ShiftLArithmetic1 s1 (a[31:0],k[31:0],m,n),
                  s2 (k[31:0],s[31:0],p,q);
or(ovfl,n,q);
endmodule
///////////////////
module ShiftLArithmetic4 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
assign cout=1'b0;
ShiftLArithmetic2 s1 (a[31:0],k[31:0],m,n),
                  s2 (k[31:0],s[31:0],p,q);
or(ovfl,n,q);
endmodule
///////////////////
module ShiftLArithmetic8 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
assign cout=1'b0;
ShiftLArithmetic4 s1 (a[31:0],k[31:0],m,n),
                  s2 (k[31:0],s[31:0],p,q);
or(ovfl,n,q);
endmodule
///////////////////
module ShiftLArithmetic16 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
assign cout=1'b0;
ShiftLArithmetic8 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],p,q);
or(ovfl,n,q);
endmodule
/////////////////////
module ShiftRArithmetic1 (input [31:0]a, output [31:0]s, output cout,ovfl);
assign s[31]=a[31];
assign s[30:0]=a[31:1];
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
////////////////////
module ShiftRArithmetic2 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
ShiftRArithmetic1 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],p,q);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftRArithmetic4 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
ShiftRArithmetic2 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],p,q);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftRArithmetic8 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
ShiftRArithmetic4 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],p,q);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module ShiftRArithmetic16 (input [31:0]a, output [31:0]s, output cout,ovfl);
wire [31:0]k;
wire m,n,p,q;
ShiftRArithmetic8 s1 (a[31:0],k[31:0],m,n),
               s2 (k[31:0],s[31:0],p,q);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module multiplier_8x1 (input [7:0]a,input b, output [7:0]s);
and(s[0],a[0],b);
and(s[1],a[1],b);
and(s[2],a[2],b);
and(s[3],a[3],b);
and(s[4],a[4],b);
and(s[5],a[5],b);
and(s[6],a[6],b);
and(s[7],a[7],b);
endmodule
///////////////////
module multiplier_8x8 (input [7:0]a,b, output [31:0]s,output cout,ovfl);
wire [31:0]r0,r1,r2,r3,r4,r5,r6,r7,k1,k2,k3,k4,k5,k6,k7,l3,l7,m6,m5,m7,s1,s2,s3,s4,s5,s6,s7;
wire c1,c2,c3,c4,c5,c6,c7;
wire [25:8]o;
wire [19:8]c;
assign cout=1'b0;
assign ovfl=1'b0;
multiplier_8x1 n0 (a[7:0],b[0],r0[7:0]),
               n1 (a[7:0],b[1],k1[7:0]),
               n2 (a[7:0],b[2],k2[7:0]),
               n3 (a[7:0],b[3],k3[7:0]),
               n4 (a[7:0],b[4],k4[7:0]),
               n5 (a[7:0],b[5],k5[7:0]),
               n6 (a[7:0],b[6],k6[7:0]),
               n7 (a[7:0],b[7],k7[7:0]);
ShiftLLogical1 p1 (k1[31:0],r1[31:0],c[8],o[8]),
               p3 (l3[31:0],r3[31:0],c[9],o[9]),
               p5 (m5[31:0],r5[31:0],c[10],o[10]),
               p7 (l7[31:0],r7[31:0],c[11],o[11]);
ShiftLLogical2 t2 (k2[31:0],r2[31:0],c[12],o[12]),
               t3 (k3[31:0],l3[31:0],c[13],o[13]),
               t6 (m6[31:0],r6[31:0],c[14],o[14]),
               t7 (m7[31:0],l7[31:0],c[15],o[15]);
ShiftLLogical4 u4 (k4[31:0],r4[31:0],c[16],o[16]),
               u5 (k5[31:0],m5[31:0],c[17],o[17]),
               u6 (k6[31:0],m6[31:0],c[18],o[18]),
               u7 (k7[31:0],m7[31:0],c[19],o[19]);
CSA_32bit add0 (r0[31:0],r1[31:0],1'b0,s1[31:0],c1,o[20]),
          add1 (s1[31:0],r2[31:0],1'b0,s2[31:0],c2,o[21]),
          add2 (s2[31:0],r3[31:0],1'b0,s3[31:0],c3,o[22]),
          add3 (s3[31:0],r4[31:0],1'b0,s4[31:0],c4,o[23]),
          add4 (s4[31:0],r5[31:0],1'b0,s5[31:0],c5,o[24]),
          add5 (s5[31:0],r6[31:0],1'b0,s6[31:0],c6,o[25]),
          add6 (s6[31:0],r7[31:0],1'b0,s7[31:0],c7,o[25]);
assign r0[31:8]=24'b0;
assign r1[31:9]=23'b0;
assign r2[31:10]=22'b0;
assign r3[31:11]=21'b0;
assign r4[31:12]=20'b0;
assign r5[31:13]=19'b0;
assign r6[31:14]=18'b0;
assign r7[31:15]=17'b0;
assign s=s7;
endmodule
///////////////////
module And_8bit (input [7:0]a,b, output [7:0]s);
and (s[0],a[0],b[0]);
and (s[1],a[1],b[1]);
and (s[2],a[2],b[2]);
and (s[3],a[3],b[3]);
and (s[4],a[4],b[4]);
and (s[5],a[5],b[5]);
and (s[6],a[6],b[6]);
and (s[7],a[7],b[7]);
endmodule
///////////////////
module And_32bit (input [31:0]a,b, output [31:0]s, output cout,ovfl);
And_8bit and1 (a[7:0],b[7:0],s[7:0]),
         and2 (a[15:8],b[15:8],s[15:8]),
         and3 (a[23:16],b[23:16],s[23:16]),
         and4 (a[31:24],b[31:24],s[31:24]);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module Or_8bit (input [7:0]a,b, output [7:0]s);
or (s[0],a[0],b[0]);
or (s[1],a[1],b[1]);
or (s[2],a[2],b[2]);
or (s[3],a[3],b[3]);
or (s[4],a[4],b[4]);
or (s[5],a[5],b[5]);
or (s[6],a[6],b[6]);
or (s[7],a[7],b[7]);
endmodule
///////////////////
module Or_32bit (input [31:0]a,b, output [31:0]s, output cout,ovfl);
Or_8bit or1 (a[7:0],b[7:0],s[7:0]),
        or2 (a[15:8],b[15:8],s[15:8]),
        or3 (a[23:16],b[23:16],s[23:16]),
        or4 (a[31:24],b[31:24],s[31:24]);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module Xor_8bit (input [7:0]a,b, output [7:0]s);
xor (s[0],a[0],b[0]);
xor (s[1],a[1],b[1]);
xor (s[2],a[2],b[2]);
xor (s[3],a[3],b[3]);
xor (s[4],a[4],b[4]);
xor (s[5],a[5],b[5]);
xor (s[6],a[6],b[6]);
xor (s[7],a[7],b[7]);
endmodule
///////////////////
module Xor_32bit (input [31:0]a,b, output [31:0]s, output cout,ovfl);
Xor_8bit xor1 (a[7:0],b[7:0],s[7:0]),
         xor2 (a[15:8],b[15:8],s[15:8]),
         xor3 (a[23:16],b[23:16],s[23:16]),
         xor4 (a[31:24],b[31:24],s[31:24]);
assign cout=1'b0;
assign ovfl=1'b0;
endmodule
///////////////////
module div_block (input a,b,ci,q , output co,r);
  wire s1;
  FA_1bit f1(a,b,ci,s1,co);
  mux m1(b,s1,q,r);
endmodule
///////////////////
module div_8x4 (input[7:0]a,input [3:0]b,output [3:0]q,output[3:0]r,output cout, ovfl);
  wire [28:0]c;
  div_block d1(b[0],a[1],c[1],q[0],c[0],c[3]),
            d2(b[1],a[2],c[4],q[0],c[1],c[5]),
            d3(b[2],a[3],c[6],q[0],c[4],c[7]),
            d4(b[3],a[4],1'b0,q[0],c[6],c[8]),
            d5(b[0],c[5],c[10],q[1],c[9],c[11]),
            d6(b[1],c[7],c[12],q[1],c[10],c[13]),
            d7(b[2],c[8],c[14],q[1],c[12],c[15]),
            d8(b[3],a[5],1'b0,q[1],c[14],c[16]),
            d9(b[0],c[13],c[18],q[2],c[17],c[19]),
            d10(b[1],c[15],c[20],q[2],c[18],c[21]),
            d11(b[2],c[16],c[22],q[2],c[20],c[23]),
            d12(b[3],a[6],1'b0,q[2],c[22],c[24]),
            d13(b[0],c[21],c[26],q[3],c[25],r[0]),
            d14(b[1],c[23],c[27],q[3],c[26],r[1]),
            d15(b[2],c[24],c[28],q[3],c[27],r[2]),
            d16(b[3],a[7],1'b0,q[3],c[28],r[3]);
  or(q[0],a[0],~c[0]);
  or(q[1],c[3],~c[9]);
  or(q[2],c[11],~c[17]);
  or(q[3],c[19],~c[25]);
  assign cout=1'b0;
  assign ovfl=1'b0;
endmodule
///////////////////
module mux_32x1 (input a31,a30,a29,a28,a27,a26,a25,a24,a23,a22,a21,a20,a19,a18,a17,a16,a15,a14,a13,a12,a11,a10,a9,a8,a7,a6,a5,a4,a3,a2,a1,a0,input [4:0]select,output o);
  wire [31:0]w;
  and(w[0],a0,~select[4],~select[3],~select[2],~select[1],~select[0]);
  and(w[1],a1,~select[4],~select[3],~select[2],~select[1],select[0]);
  and(w[2],a2,~select[4],~select[3],~select[2],select[1],~select[0]);
  and(w[3],a3,~select[4],~select[3],~select[2],select[1],select[0]);
  and(w[4],a4,~select[4],~select[3],select[2],~select[1],~select[0]);
  and(w[5],a5,~select[4],~select[3],select[2],~select[1],select[0]);
  and(w[6],a6,~select[4],~select[3],select[2],select[1],~select[0]);
  and(w[7],a7,~select[4],~select[3],select[2],select[1],select[0]);
  and(w[8],a8,~select[4],select[3],~select[2],~select[1],~select[0]);
  and(w[9],a9,~select[4],select[3],~select[2],~select[1],select[0]);
  and(w[10],a10,~select[4],select[3],~select[2],select[1],~select[0]);
  and(w[11],a11,~select[4],select[3],~select[2],select[1],select[0]);
  and(w[12],a12,~select[4],select[3],select[2],~select[1],~select[0]);
  and(w[13],a13,~select[4],select[3],select[2],~select[1],select[0]);
  and(w[14],a14,~select[4],select[3],select[2],select[1],~select[0]);
  and(w[15],a15,~select[4],select[3],select[2],select[1],select[0]);
  and(w[16],a16,select[4],~select[3],~select[2],~select[1],~select[0]);
  and(w[17],a17,select[4],~select[3],~select[2],~select[1],select[0]);
  and(w[18],a18,select[4],~select[3],~select[2],select[1],~select[0]);
  and(w[19],a19,select[4],~select[3],~select[2],select[1],select[0]);
  and(w[20],a20,select[4],~select[3],select[2],~select[1],~select[0]);
  and(w[21],a21,select[4],~select[3],select[2],~select[1],select[0]);
  and(w[22],a22,select[4],~select[3],select[2],select[1],~select[0]);
  and(w[23],a23,select[4],~select[3],select[2],select[1],select[0]);
  and(w[24],a24,select[4],select[3],~select[2],~select[1],~select[0]);
  and(w[25],a25,select[4],select[3],~select[2],~select[1],select[0]);
  and(w[26],a26,select[4],select[3],~select[2],select[1],~select[0]);
  and(w[27],a27,select[4],select[3],~select[2],select[1],select[0]);
  and(w[28],a28,select[4],select[3],select[2],~select[1],~select[0]);
  and(w[29],a29,select[4],select[3],select[2],~select[1],select[0]);
  and(w[30],a30,select[4],select[3],select[2],select[1],~select[0]);
  and(w[31],a31,select[4],select[3],select[2],select[1],select[0]);
  or(o,w[0],w[1],w[2],w[3],w[4],w[5],w[6],w[7],w[8],w[9],w[10],w[11],w[12],w[13],w[14],w[15],w[16],w[17],w[18],w[19],w[20],w[21],w[22],w[23],w[24],w[25],w[26],w[27],w[28],w[29],w[30],w[31]);
endmodule
////////////////////
module ALU_32bitNEW (input [4:0]select, input [31:0]a,b, output [31:0]c, output cout,ovfl);
wire [31:0]s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,co,ov;
assign co[7]=co[8];
assign ov[7]=ov[8];
RCA_32bit f0 (a,b,1'b0,s0,co[0],ov[0]),
          f1 (a,b,1'b1,s3,co[3],ov[3]);
CSA_32bit f2 (a,b,1'b0,s1,co[1],ov[1]),
          f3 (a,b,1'b1,s4,co[4],ov[4]);
CLA_32bit f4 (a,b,1'b0,s2,co[2],ov[2]),
          f5 (a,b,1'b1,s5,co[5],ov[5]);
multiplier_8x8 f6 (a[7:0],b[7:0],s6,co[6],ov[6]);
EN_not f7 (a,1'b1,s7);
And_32bit f8 (a,b,s8,co[8],ov[8]);
Or_32bit f9 (a,b,s9,co[9],ov[9]);
Xor_32bit f10 (a,b,s10,co[10],ov[10]);
ShiftRLogical1 f11 (a,s11,co[11],ov[11]);
ShiftRLogical2 f12 (a,s12,co[12],ov[12]);
ShiftRLogical4 f13 (a,s13,co[13],ov[13]);
ShiftRLogical8 f14 (a,s14,co[14],ov[14]);
ShiftRLogical16 f15 (a,s15,co[15],ov[15]);
ShiftRArithmetic1 f16 (a,s16,co[16],ov[16]);
ShiftRArithmetic2 f17 (a,s17,co[17],ov[17]);
ShiftRArithmetic4 f18 (a,s18,co[18],ov[18]);
ShiftRArithmetic8 f19(a,s19,co[19],ov[19]);
ShiftRArithmetic16 f20 (a,s20,co[20],ov[20]);
ShiftLLogical1 f21 (a,s21,co[21],ov[21]);
ShiftLLogical2 f22 (a,s22,co[22],ov[22]);
ShiftLLogical4 f23 (a,s23,co[23],ov[23]);
ShiftLLogical8 f24 (a,s24,co[24],ov[24]);
ShiftLLogical16 f25 (a,s25,co[25],ov[25]);
ShiftLArithmetic1 f26 (a,s26,co[26],ov[26]);
ShiftLArithmetic2 f27 (a,s27,co[27],ov[27]);
ShiftLArithmetic4 f28 (a,s28,co[28],ov[28]);
ShiftLArithmetic8 f29 (a,s29,co[29],ov[29]);
ShiftLArithmetic16 f30 (a,s30,co[30],ov[30]);
mux_32x1 m0 (s31[0],s30[0],s29[0],s28[0],s27[0],s26[0],s25[0],s24[0],s23[0],s22[0],s21[0],s20[0],s19[0],s18[0],s17[0],s16[0],s15[0],s14[0],s13[0],s12[0],s11[0],s10[0],s9[0],s8[0],s7[0],s6[0],s5[0],s4[0],s3[0],s2[0],s1[0],s0[0],select,c[0]),
         m1 (s31[1],s30[1],s29[1],s28[1],s27[1],s26[1],s25[1],s24[1],s23[1],s22[1],s21[1],s20[1],s19[1],s18[1],s17[1],s16[1],s15[1],s14[1],s13[1],s12[1],s11[1],s10[1],s9[1],s8[1],s7[1],s6[1],s5[1],s4[1],s3[1],s2[1],s1[1],s0[1],select,c[1]),
         m2 (s31[2],s30[2],s29[2],s28[2],s27[2],s26[2],s25[2],s24[2],s23[2],s22[2],s21[2],s20[2],s19[2],s18[2],s17[2],s16[2],s15[2],s14[2],s13[2],s12[2],s11[2],s10[2],s9[2],s8[2],s7[2],s6[2],s5[2],s4[2],s3[2],s2[2],s1[2],s0[2],select,c[2]),
         m3 (s31[3],s30[3],s29[3],s28[3],s27[3],s26[3],s25[3],s24[3],s23[3],s22[3],s21[3],s20[3],s19[3],s18[3],s17[3],s16[3],s15[3],s14[3],s13[3],s12[3],s11[3],s10[3],s9[3],s8[3],s7[3],s6[3],s5[3],s4[3],s3[3],s2[3],s1[3],s0[3],select,c[3]),
         m4 (s31[4],s30[4],s29[4],s28[4],s27[4],s26[4],s25[4],s24[4],s23[4],s22[4],s21[4],s20[4],s19[4],s18[4],s17[4],s16[4],s15[4],s14[4],s13[4],s12[4],s11[4],s10[4],s9[4],s8[4],s7[4],s6[4],s5[4],s4[4],s3[4],s2[4],s1[4],s0[4],select,c[4]),
         m5 (s31[5],s30[5],s29[5],s28[5],s27[5],s26[5],s25[5],s24[5],s23[5],s22[5],s21[5],s20[5],s19[5],s18[5],s17[5],s16[5],s15[5],s14[5],s13[5],s12[5],s11[5],s10[5],s9[5],s8[5],s7[5],s6[5],s5[5],s4[5],s3[5],s2[5],s1[5],s0[5],select,c[5]),
         m6 (s31[6],s30[6],s29[6],s28[6],s27[6],s26[6],s25[6],s24[6],s23[6],s22[6],s21[6],s20[6],s19[6],s18[6],s17[6],s16[6],s15[6],s14[6],s13[6],s12[6],s11[6],s10[6],s9[6],s8[6],s7[6],s6[6],s5[6],s4[6],s3[6],s2[6],s1[6],s0[6],select,c[6]),
         m7 (s31[7],s30[7],s29[7],s28[7],s27[7],s26[7],s25[7],s24[7],s23[7],s22[7],s21[7],s20[7],s19[7],s18[7],s17[7],s16[7],s15[7],s14[7],s13[7],s12[7],s11[7],s10[7],s9[7],s8[7],s7[7],s6[7],s5[7],s4[7],s3[7],s2[7],s1[7],s0[7],select,c[7]),
         m8 (s31[8],s30[8],s29[8],s28[8],s27[8],s26[8],s25[8],s24[8],s23[8],s22[8],s21[8],s20[8],s19[8],s18[8],s17[8],s16[8],s15[8],s14[8],s13[8],s12[8],s11[8],s10[8],s9[8],s8[8],s7[8],s6[8],s5[8],s4[8],s3[8],s2[8],s1[8],s0[8],select,c[8]),
         m9 (s31[9],s30[9],s29[9],s28[9],s27[9],s26[9],s25[9],s24[9],s23[9],s22[9],s21[9],s20[9],s19[9],s18[9],s17[9],s16[9],s15[9],s14[9],s13[9],s12[9],s11[9],s10[9],s9[9],s8[9],s7[9],s6[9],s5[9],s4[9],s3[9],s2[9],s1[9],s0[9],select,c[9]),
         m10 (s31[10],s30[10],s29[10],s28[10],s27[10],s26[10],s25[10],s24[10],s23[10],s22[10],s21[10],s20[10],s19[10],s18[10],s17[10],s16[10],s15[10],s14[10],s13[10],s12[10],s11[10],s10[10],s9[10],s8[10],s7[10],s6[10],s5[10],s4[10],s3[10],s2[10],s1[10],s0[10],select,c[10]),
         m11 (s31[11],s30[11],s29[11],s28[11],s27[11],s26[11],s25[11],s24[11],s23[11],s22[11],s21[11],s20[11],s19[11],s18[11],s17[11],s16[11],s15[11],s14[11],s13[11],s12[11],s11[11],s10[11],s9[11],s8[11],s7[11],s6[11],s5[11],s4[11],s3[11],s2[11],s1[11],s0[11],select,c[11]),
         m12 (s31[12],s30[12],s29[12],s28[12],s27[12],s26[12],s25[12],s24[12],s23[12],s22[12],s21[12],s20[12],s19[12],s18[12],s17[12],s16[12],s15[12],s14[12],s13[12],s12[12],s11[12],s10[12],s9[12],s8[12],s7[12],s6[12],s5[12],s4[12],s3[12],s2[12],s1[12],s0[12],select,c[12]),
         m13 (s31[13],s30[13],s29[13],s28[13],s27[13],s26[13],s25[13],s24[13],s23[13],s22[13],s21[13],s20[13],s19[13],s18[13],s17[13],s16[13],s15[13],s14[13],s13[13],s12[13],s11[13],s10[13],s9[13],s8[13],s7[13],s6[13],s5[13],s4[13],s3[13],s2[13],s1[13],s0[13],select,c[13]),
         m14 (s31[14],s30[14],s29[14],s28[14],s27[14],s26[14],s25[14],s24[14],s23[14],s22[14],s21[14],s20[14],s19[14],s18[14],s17[14],s16[14],s15[14],s14[14],s13[14],s12[14],s11[14],s10[14],s9[14],s8[14],s7[14],s6[14],s5[14],s4[14],s3[14],s2[14],s1[14],s0[14],select,c[14]),
         m15 (s31[15],s30[15],s29[15],s28[15],s27[15],s26[15],s25[15],s24[15],s23[15],s22[15],s21[15],s20[15],s19[15],s18[15],s17[15],s16[15],s15[15],s14[15],s13[15],s12[15],s11[15],s10[15],s9[15],s8[15],s7[15],s6[15],s5[15],s4[15],s3[15],s2[15],s1[15],s0[15],select,c[15]),
         m16 (s31[16],s30[16],s29[16],s28[16],s27[16],s26[16],s25[16],s24[16],s23[16],s22[16],s21[16],s20[16],s19[16],s18[16],s17[16],s16[16],s15[16],s14[16],s13[16],s12[16],s11[16],s10[16],s9[16],s8[16],s7[16],s6[16],s5[16],s4[16],s3[16],s2[16],s1[16],s0[16],select,c[16]),
         m17 (s31[17],s30[17],s29[17],s28[17],s27[17],s26[17],s25[17],s24[17],s23[17],s22[17],s21[17],s20[17],s19[17],s18[17],s17[17],s16[17],s15[17],s14[17],s13[17],s12[17],s11[17],s10[17],s9[17],s8[17],s7[17],s6[17],s5[17],s4[17],s3[17],s2[17],s1[17],s0[17],select,c[17]),
         m18 (s31[18],s30[18],s29[18],s28[18],s27[18],s26[18],s25[18],s24[18],s23[18],s22[18],s21[18],s20[18],s19[18],s18[18],s17[18],s16[18],s15[18],s14[18],s13[18],s12[18],s11[18],s10[18],s9[18],s8[18],s7[18],s6[18],s5[18],s4[18],s3[18],s2[18],s1[18],s0[18],select,c[18]),
         m19 (s31[19],s30[19],s29[19],s28[19],s27[19],s26[19],s25[19],s24[19],s23[19],s22[19],s21[19],s20[19],s19[19],s18[19],s17[19],s16[19],s15[19],s14[19],s13[19],s12[19],s11[19],s10[19],s9[19],s8[19],s7[19],s6[19],s5[19],s4[19],s3[19],s2[19],s1[19],s0[19],select,c[19]),
         m20 (s31[20],s30[20],s29[20],s28[20],s27[20],s26[20],s25[20],s24[20],s23[20],s22[20],s21[20],s20[20],s19[20],s18[20],s17[20],s16[20],s15[20],s14[20],s13[20],s12[20],s11[20],s10[20],s9[20],s8[20],s7[20],s6[20],s5[20],s4[20],s3[20],s2[20],s1[20],s0[20],select,c[20]),
         m21 (s31[21],s30[21],s29[21],s28[21],s27[21],s26[21],s25[21],s24[21],s23[21],s22[21],s21[21],s20[21],s19[21],s18[21],s17[21],s16[21],s15[21],s14[21],s13[21],s12[21],s11[21],s10[21],s9[21],s8[21],s7[21],s6[21],s5[21],s4[21],s3[21],s2[21],s1[21],s0[21],select,c[21]),
         m22 (s31[22],s30[22],s29[22],s28[22],s27[22],s26[22],s25[22],s24[22],s23[22],s22[22],s21[22],s20[22],s19[22],s18[22],s17[22],s16[22],s15[22],s14[22],s13[22],s12[22],s11[22],s10[22],s9[22],s8[22],s7[22],s6[22],s5[22],s4[22],s3[22],s2[22],s1[22],s0[22],select,c[22]),
         m23 (s31[23],s30[23],s29[23],s28[23],s27[23],s26[23],s25[23],s24[23],s23[23],s22[23],s21[23],s20[23],s19[23],s18[23],s17[23],s16[23],s15[23],s14[23],s13[23],s12[23],s11[23],s10[23],s9[23],s8[23],s7[23],s6[23],s5[23],s4[23],s3[23],s2[23],s1[23],s0[23],select,c[23]),
         m24 (s31[24],s30[24],s29[24],s28[24],s27[24],s26[24],s25[24],s24[24],s23[24],s22[24],s21[24],s20[24],s19[24],s18[24],s17[24],s16[24],s15[24],s14[24],s13[24],s12[24],s11[24],s10[24],s9[24],s8[24],s7[24],s6[24],s5[24],s4[24],s3[24],s2[24],s1[24],s0[24],select,c[24]),
         m25 (s31[25],s30[25],s29[25],s28[25],s27[25],s26[25],s25[25],s24[25],s23[25],s22[25],s21[25],s20[25],s19[25],s18[25],s17[25],s16[25],s15[25],s14[25],s13[25],s12[25],s11[25],s10[25],s9[25],s8[25],s7[25],s6[25],s5[25],s4[25],s3[25],s2[25],s1[25],s0[25],select,c[25]),
         m26 (s31[26],s30[26],s29[26],s28[26],s27[26],s26[26],s25[26],s24[26],s23[26],s22[26],s21[26],s20[26],s19[26],s18[26],s17[26],s16[26],s15[26],s14[26],s13[26],s12[26],s11[26],s10[26],s9[26],s8[26],s7[26],s6[26],s5[26],s4[26],s3[26],s2[26],s1[26],s0[26],select,c[26]),
         m27 (s31[27],s30[27],s29[27],s28[27],s27[27],s26[27],s25[27],s24[27],s23[27],s22[27],s21[27],s20[27],s19[27],s18[27],s17[27],s16[27],s15[27],s14[27],s13[27],s12[27],s11[27],s10[27],s9[27],s8[27],s7[27],s6[27],s5[27],s4[27],s3[27],s2[27],s1[27],s0[27],select,c[27]),
         m28 (s31[28],s30[28],s29[28],s28[28],s27[28],s26[28],s25[28],s24[28],s23[28],s22[28],s21[28],s20[28],s19[28],s18[28],s17[28],s16[28],s15[28],s14[28],s13[28],s12[28],s11[28],s10[28],s9[28],s8[28],s7[28],s6[28],s5[28],s4[28],s3[28],s2[28],s1[28],s0[28],select,c[28]),
         m29 (s31[29],s30[29],s29[29],s28[29],s27[29],s26[29],s25[29],s24[29],s23[29],s22[29],s21[29],s20[29],s19[29],s18[29],s17[29],s16[29],s15[29],s14[29],s13[29],s12[29],s11[29],s10[29],s9[29],s8[29],s7[29],s6[29],s5[29],s4[29],s3[29],s2[29],s1[29],s0[29],select,c[29]),
         m30 (s31[30],s30[30],s29[30],s28[30],s27[30],s26[30],s25[30],s24[30],s23[30],s22[30],s21[30],s20[30],s19[30],s18[30],s17[30],s16[30],s15[30],s14[30],s13[30],s12[30],s11[30],s10[30],s9[30],s8[30],s7[30],s6[30],s5[30],s4[30],s3[30],s2[30],s1[30],s0[30],select,c[30]),
         m31 (s31[31],s30[31],s29[31],s28[31],s27[31],s26[31],s25[31],s24[31],s23[31],s22[31],s21[31],s20[31],s19[31],s18[31],s17[31],s16[31],s15[31],s14[31],s13[31],s12[31],s11[31],s10[31],s9[31],s8[31],s7[31],s6[31],s5[31],s4[31],s3[31],s2[31],s1[31],s0[31],select,c[31]),
         m32 (co[31],co[30],co[29],co[28],co[27],co[26],co[25],co[24],co[23],co[22],co[21],co[20],co[19],co[18],co[17],co[16],co[15],co[14],co[13],co[12],co[11],co[10],co[9],co[8],co[7],co[6],co[5],co[4],co[3],co[2],co[1],co[0],select,cout),
         m33 (ov[31],ov[30],ov[29],ov[28],ov[27],ov[26],ov[25],ov[24],ov[23],ov[22],ov[21],ov[20],ov[19],ov[18],ov[17],ov[16],ov[15],ov[14],ov[13],ov[12],ov[11],ov[10],ov[9],ov[8],ov[7],ov[6],ov[5],ov[4],ov[3],ov[2],ov[1],ov[0],select,ovfl);
endmodule