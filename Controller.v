module ControlUnitMIPS (input [5:0]CtrlInstr,CtrlInstrIF,CtrlInstrIF1,func,input clk, output reg RegWrite,ExrWrite,RdReg2,MemWrite,MemRead, output reg [1:0]PCsrc,WrData,WrReg,RdReg1,output reg [4:0]select);
  localparam [5:0] Rtype=6'b000000, JL=6'b000001, Jr=6'b000010, Exm=6'b000011, Exr=6'b000100;
  reg [2:0] counterExr;
  reg counterExm,counterExr1;
  initial begin
    counterExm=1'b0;
    counterExr=3'b0;
    counterExr1=1'b0;
  end
  always @ (posedge clk) begin
      case(CtrlInstr)
        Rtype: begin
        RegWrite=1'b1;
        ExrWrite=1'b0;
        RdReg2=1'b0;
        MemWrite=1'b0;
        MemRead=1'b0;
        PCsrc=2'b00;
        WrData=2'b00;
        WrReg=2'b00;
        RdReg1=2'b00;
        if(func==6'b000000)begin
           select=5'b00010;
        end
    
        if(func==6'b000001)begin
            select=5'b01000;
         end
    
        if(func==6'b000010)begin
           select=5'b01001;
        end
    
        if(func==6'b000011)begin
           select=5'b00111;
        end
        end
        
        JL: begin
        RegWrite=1'b1;
        ExrWrite=1'b0;
        RdReg2=1'b0;
        MemWrite=1'b0;
        MemRead=1'b0;
        PCsrc=2'b10;
        WrData=2'b01;
        WrReg=2'b01;
        RdReg1=2'b00;
        end
        
        Jr: begin
        RegWrite=1'b0;
        ExrWrite=1'b0;
        RdReg2=1'b0;
        MemWrite=1'b0;
        MemRead=1'b0;
        PCsrc=2'b11;
        WrData=2'b00;
        WrReg=2'b00;
        RdReg1=2'b00;
        end
        
        Exm: begin
        RegWrite=1'b0;
        ExrWrite=1'b0;
        RdReg2=1'b0;
        MemWrite=1'b0;
        MemRead=1'b1;
        WrData=2'b00;
        WrReg=2'b00;
        RdReg1=2'b00;
        PCsrc=2'b00;
        if (counterExm==1'b1) begin
        RegWrite=1'b0;
        ExrWrite=1'b0;
        RdReg2=1'b0;
        MemWrite=1'b1;
        MemRead=1'b0;
        WrData=2'b00;
        WrReg=2'b00;
        RdReg1=2'b00;
        PCsrc=2'b00;
        counterExm=1'b0;
        end
      else if (counterExm==1'b0) begin
        counterExm=1'b1;
      end
        end
        
        Exr: begin
        RegWrite=1'b0;
        ExrWrite=1'b0;
        RdReg2=1'b1;
        MemWrite=1'b0;
        MemRead=1'b0;
        WrData=2'b00;
        WrReg=2'b00;
        RdReg1=2'b01;
        PCsrc=2'b00;
        if (counterExr==3'b001) begin
        RegWrite=1'b1;
        ExrWrite=1'b1;
        RdReg2=1'b1;
        MemWrite=1'b0;
        MemRead=1'b0;
        WrData=2'b10;
        WrReg=2'b00;
        RdReg1=2'b01;
        PCsrc=2'b00;
        counterExr=counterExr+1;
      end
      else if (counterExr==3'b010) begin
        RegWrite=1'b1;
        ExrWrite=1'b0;
        RdReg2=1'b1;
        MemWrite=1'b0;
        MemRead=1'b0;
        WrData=2'b00;
        WrReg=2'b10;
        RdReg1=2'b11;
        PCsrc=2'b00;
        counterExr=3'b000;
        end
      else if (counterExr==3'b000) begin
        counterExr=3'b001;
      end
        end
      
        default:begin
        RegWrite=1'b0;
        ExrWrite=1'b0;
        RdReg2=1'b0;
        MemWrite=1'b0;
        MemRead=1'b0;
        PCsrc=2'b00;
        WrData=2'b00;
        WrReg=2'b00;
        RdReg1=2'b00;
        end
     endcase
     if (CtrlInstrIF==6'b000011) begin
      if (counterExm==1'b0) begin
        PCsrc=2'b01;
        end
      end
      if (counterExr1==1'b1) begin
        PCsrc=2'b01;
        counterExr1=1'b0;
        end
      if (CtrlInstrIF==6'b000100) begin
      if (counterExr==3'b000) begin
        PCsrc=2'b01;
        counterExr1=1'b1;
        end
      end
  else if (counterExr==3'b011) counterExr=counterExr+1;
  else if (counterExr==3'b100) begin
  counterExr=counterExr+1;
  PCsrc=2'b01;
  end
  else if (counterExr==3'b101) begin 
  counterExr=3'b000;
  PCsrc=2'b01;
  end
    end
          endmodule
///////////////////////////////////////////////
module AluController (input [5:0]opcode,input clk,Aluop_en, output reg [4:0]select);
  localparam [5:0] Add=6'b000000, And=6'b000001, Or=6'b000010, Not=6'b000011;
  always @ (posedge clk) begin
    if (Aluop_en) begin
  case(opcode)
    Add: begin
      select=5'b00010;
    end
    
    And: begin
      select=5'b01000;
    end
    
    Or: begin
      select=5'b01001;
    end
    
    Not: begin
      select=5'b00111;
    end
  endcase
  end
  end
endmodule