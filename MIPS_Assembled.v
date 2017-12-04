module CA_MIPS (input [4:0]ALUOP, input clk,RegWrite,ExrWrite,RdReg2,MemWrite,MemRead, input [1:0]PCsrc,WrData,WrReg,RdReg1, output [5:0]CtrlInstr,CtrlInstrIF,CtrlInstrIF1,func);
//CU
wire RegWriteEX,RegWriteMEM,RegWriteWB,MemReadEX,MemReadMEM,MemWriteEX,MemWriteMEM,RdReg2EX,RdReg2MEM,RdReg2WB,ExrWriteEX,ExrWriteMEM,ExrWriteWB;
wire [1:0]PCsrcEX,PCsrcMEM,RdReg1EX,RdReg1MEM,RdReg1WB,WrDataEX,WrDataMEM,WrDataWB,WrRegEX,WrRegMEM,WrRegWB;
wire [4:0]ALUOPEX;
//ID
  wire [31:0]WRdata0,ReadData1ID,ReadData2ID,ReadData3ID,OffsetID,PC4EX,ReadData1EX,ReadData2EX,InstrEX,JAID;
  wire [4:0]ReadAd1,ReadAd2,WRdst;
//EX
 wire [31:0] AluResEX,PC8EX,PC8MEM,PC4MEM,AluResMEM,InstrMEM;
//MEM
wire [31:0]Data1,Data2,rData1,rData2,PC4WB,AluResWB,PCmux10EX;
//WB
  wire [1:0]RdReg1sel;
  wire RdReg2sel,ExrWriteWB1;

  //////////////////INSTRUCTION FETCH//////////////////////
  wire [31:0]PCout,InstrIF,InstrID,PC4IF,PCmux01,PCmux10,PCmux11,PC4ID,InstrWB;
  wire co,ov;
  wire [31:0]PCin;
  mux_4x32 Mux_PC (PC4IF,PCmux01,PCmux10EX,PCmux11,PCsrc,PCin);
  assign PCmux01=PCout;
  CSA_32bit IFCSA (PCout,32'b00000000000000000000000000000100,1'b0,PC4IF,co,ov);
  reg_32bit R0 (PCin,1'b1,1'b1,clk,PCout);
  InstrMem IM0 (PCout,InstrIF,CtrlInstrIF);
  Latch_32bit IF_ID_Instr (InstrIF,clk,InstrID),
              IF_ID_PC4 (PC4IF,clk,PC4ID),
              PCin_PCout (PCin,clk,PCout);
  assign CtrlInstrIF1=InstrIF[31:26];
  //////////////////INSTRUCTION DECODE/////////////////////
  
  assign CtrlInstr=InstrID[31:26];
  mux_4x5 Mux_ReadRegister1 (InstrID[25:21],InstrWB[25:21],InstrWB[20:16],5'b00000,RdReg1sel,ReadAd1),
          Mux_WriteRegister (InstrWB[15:11],5'b11111,InstrWB[20:16],5'b00000,WrRegWB,WRdst);
  mux_2x5 Mux_ReadRegister2 (InstrID[20:16],InstrWB[20:16],RdReg2sel,ReadAd2);
  mux_4x32 Mux_WriteData (AluResWB,PC4EX,ReadData1ID,32'b00000000000000000000000000000000,WrDataWB,WRdata0);
  RegisterFile RF0 (ReadAd1,ReadAd2,WRdst,WRdata0,RegWriteWB,ExrWriteWB1,clk,ReadData1ID,ReadData2ID,ReadData3ID);
  ShiftLLogical2 ShiftForJA (InstrID,JAID,co,ov);
  assign PCmux10[31:28]=PC4ID[31:28];
  assign PCmux10[27:0]=JAID[27:0];
  assign PCmux11=ReadData3ID;
  ////**control unit**////
  Latch_32bit ID_EX_ReadData1 (ReadData1ID,clk,ReadData1EX),
              ID_EX_ReadData2 (ReadData2ID,clk,ReadData2EX),
              ID_EX_Instr (InstrID,clk,InstrEX),
              ID_EX_PC4 (PC4ID,clk,PC4EX),
              ID_EX_PCmux10 (PCmux10,clk,PCmux10EX);
  
  //////////////////EXECUTE///////////////////////////////
    CSA_32bit EXCSA (PC4EX,32'b00000000000000000000000000000100,1'b0,PC8EX,co,ov);
    ALU_32bitNEW ALU_Ex (ALUOPEX,ReadData1EX,ReadData2EX,AluResEX,co,ov);
    Latch_32bit EX_MEM_PC4 (PC4EX,clk,PC4MEM),
                EX_MEM_PC8 (PC8EX,clk,PC8MEM),
                EX_MEM_AluRes (AluResEX,clk,AluResMEM),
                EX_MEM_Instr (InstrEX,clk,InstrMEM);
  assign func=InstrID[5:0];
  ////////////////////MEMORY ACCESS//////////////////////
  Latch_32bit EXM_Latch_Wr1 (Data1,MemWriteMEM,rData1),
             EXM_Latch_Wr2 (Data2,MemWriteMEM,rData2);
  DataMem MEM_ACCESS(PC4MEM,PC8MEM,rData2,rData1,MemReadMEM,MemWriteMEM,Data1,Data2);
  Latch_32bit MEM_WB_PC4 (PC4MEM,clk,PC4WB),
              MEM_WB_AluRes (AluResMEM,clk,AluResWB),
              MEM_WB_Instr (InstrMEM,clk,InstrWB);
  //////////////////////WRITE BACK///////////////////////
  reg a,b,c;
  initial begin
    a=1'b0;
    b=1'b0;
    c=1'b0;
  end
  always@ (posedge clk) begin
    a=1'b0;
    b=1'b0;
    c=1'b0;
    if (RdReg1WB[0]) begin
    a=1'b1;
  end
  if (RdReg2WB) begin
    b=1'b1;
  end
  if (ExrWriteWB) begin
    c=1'b1;
  end
  end
  and(RdReg1sel[1],a,RdReg1WB[1]);
  and(RdReg1sel[0],a,1'b1);
  and(RdReg2sel,b,RdReg2WB);
  and(ExrWriteWB1,c,ExrWriteWB);
  /////////////////CONTROL SIGNALS PATH//////////////////

Latch_1bit CtrlLA0 (RegWrite,clk,RegWriteMEM),
           //CtrlLA1 (RegWriteEX,clk,RegWriteMEM),
           CtrlLA2 (RegWriteMEM,clk,RegWriteWB),
           CtrlLA3 (MemRead,clk,MemReadMEM),
           //CtrlLA4 (MemReadEX,clk,MemReadMEM),
           CtrlLA5 (MemWrite,clk,MemWriteMEM),
           //CtrlLA6 (MemWriteEX,clk,MemWriteMEM),
           CtrlLA7 (RdReg2,clk,RdReg2MEM),
           //CtrlLA8 (RdReg2EX,clk,RdReg2MEM),
           CtrlLA9 (RdReg2MEM,clk,RdReg2WB),
           CtrlLA10 (ExrWrite,clk,ExrWriteMEM),
           //CtrlLA11 (ExrWriteEX,clk,ExrWriteMEM),
           CtrlLA12 (ExrWriteMEM,clk,ExrWriteWB);
Latch_2bit CtrlLA13 (PCsrc,clk,PCsrcMEM),
           //CtrlLA14 (PCsrcEX,clk,PCsrcMEM),
           CtrlLA15 (RdReg1,clk,RdReg1MEM),
           //CtrlLA16 (RdReg1EX,clk,RdReg1MEM),
           CtrlLA17 (RdReg1MEM,clk,RdReg1WB),
           CtrlLA18 (WrData,clk,WrDataMEM),
           //CtrlLA19 (WrDataEX,clk,WrDataMEM),
           CtrlLA20 (WrDataMEM,clk,WrDataWB),
           CtrlLA21 (WrReg,clk,WrRegMEM),
           //CtrlLA22 (WrRegEX,clk,WrRegMEM),
           CtrlLA23 (WrRegMEM,clk,WrRegWB);
//Latch_5bit CtrlLA24 (ALUOP,clk,ALUOPEX);
assign ALUOPEX=ALUOP;
endmodule

///////////////////////////////////////////////////////////////////////////
module Assembled_MIPS (input clk);
  wire [4:0]ALUOP;
  wire RegWrite,ExrWrite,RdReg2,MemWrite,MemRead;
  wire [1:0]PCsrc,WrData,WrReg,RdReg1;
  wire [5:0]CtrlInstr,func,CtrlInstrIF,CtrlInstrIF1;
  CA_MIPS Hardware_Design (ALUOP,clk,RegWrite,ExrWrite,RdReg2,MemWrite,MemRead,PCsrc,WrData,WrReg,RdReg1,CtrlInstr,CtrlInstrIF,CtrlInstrIF1,func);
  ControlUnitMIPS Controlling_Unit (CtrlInstr,CtrlInstrIF,CtrlInstrIF1,func,clk,RegWrite,ExrWrite,RdReg2,MemWrite,MemRead,PCsrc,WrData,WrReg,RdReg1,ALUOP);
endmodule