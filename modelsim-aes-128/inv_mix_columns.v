
//`include "tables.v"
//import tables;

module inv_mix_columns(
    input wire clk,
    input wire reset,
    input wire [127:0] state_imc_in,
    output wire [127:0] state_imc_out
	);
	
		
	//Internal logic
	reg [127:0] temp; 
	reg [127:0] state_imc_out_reg; 
	reg [127:0] state_imc_out_next;
	
	wire [127:0] mul_14_out;
	reg [127:0] mul_14_reg;
	
	wire [127:0] mul_13_out;
	reg [127:0] mul_13_reg;
	
	wire [127:0] mul_11_out;
	reg [127:0] mul_11_reg;
	
	wire [127:0] mul_9_out;
	reg [127:0] mul_9_reg;
	
	
	
	always @*
    begin
//    	//Combinational logic
    	state_imc_out_next = state_imc_in;
    	
        temp[127:120] =  gm14(state_imc_out_next[127:120]) ^ gm11(state_imc_out_next[119:112]) ^ gm13(state_imc_out_next[111:104]) ^ gm9(state_imc_out_next[103:96]); //+
        temp[119:112] =  gm9(state_imc_out_next[127:120]) ^  gm14(state_imc_out_next[119:112]) ^ gm11(state_imc_out_next[111:104]) ^ gm13(state_imc_out_next[103:96]);  //+
        temp[111:104] =  gm13(state_imc_out_next[127:120]) ^ gm9(state_imc_out_next[119:112]) ^ gm14(state_imc_out_next[111:104]) ^ gm11(state_imc_out_next[103:96]);  //+
        temp[103:96] =   gm11(state_imc_out_next[127:120]) ^ gm13(state_imc_out_next[119:112]) ^ gm9(state_imc_out_next[111:104]) ^ gm14(state_imc_out_next[103:96]);   //+
    
        temp[95:88] = gm14(state_imc_out_next[95:88]) ^ gm11(state_imc_out_next[87:80]) ^ gm13(state_imc_out_next[79:72]) ^ gm9(state_imc_out_next[71:64]); //+
        temp[87:80] = gm9(state_imc_out_next[95:88])  ^ gm14(state_imc_out_next[87:80]) ^ gm11(state_imc_out_next[79:72]) ^ gm13(state_imc_out_next[71:64]); //+
        temp[79:72] = gm13(state_imc_out_next[95:88]) ^ gm9(state_imc_out_next[87:80])  ^ gm14(state_imc_out_next[79:72]) ^ gm11(state_imc_out_next[71:64]); //+
        temp[71:64] = gm11(state_imc_out_next[95:88]) ^ gm13(state_imc_out_next[87:80]) ^ gm9(state_imc_out_next[79:72]) ^ gm14(state_imc_out_next[71:64]); //+
    
        temp[63:56] = gm14(state_imc_out_next[63:56]) ^ gm11(state_imc_out_next[55:48]) ^ gm13(state_imc_out_next[47:40]) ^ gm9(state_imc_out_next[39:32]); //+
        temp[55:48] = gm9(state_imc_out_next[63:56])  ^ gm14(state_imc_out_next[55:48]) ^ gm11(state_imc_out_next[47:40]) ^ gm13(state_imc_out_next[39:32]); //+
        temp[47:40] = gm13(state_imc_out_next[63:56]) ^ gm9(state_imc_out_next[55:48])  ^ gm14(state_imc_out_next[47:40]) ^ gm11(state_imc_out_next[39:32]); //+
        temp[39:32] = gm11(state_imc_out_next[63:56]) ^ gm13(state_imc_out_next[55:48]) ^ gm9(state_imc_out_next[47:40]) ^ gm14(state_imc_out_next[39:32]); //+
        
        temp[31:24] = gm14(state_imc_out_next[31:24]) ^ gm11(state_imc_out_next[23:16]) ^ gm13(state_imc_out_next[15:8]) ^ gm9(state_imc_out_next[7:0]); //+
        temp[23:16] = gm9(state_imc_out_next[31:24])  ^ gm14(state_imc_out_next[23:16]) ^ gm11(state_imc_out_next[15:8]) ^ gm13(state_imc_out_next[7:0]); //+
        temp[15:8] =  gm13(state_imc_out_next[31:24]) ^ gm9(state_imc_out_next[23:16])  ^ gm14(state_imc_out_next[15:8]) ^ gm11(state_imc_out_next[7:0]);  //+
        temp[7:0] =   gm11(state_imc_out_next[31:24]) ^ gm13(state_imc_out_next[23:16]) ^ gm9(state_imc_out_next[15:8])  ^ gm14(state_imc_out_next[7:0]);   //+
        
        state_imc_out_next[127:0] = temp[127:0];


    end
    
    assign state_imc_out = state_imc_out_next;
    
    
  function [7 : 0] gm2(input [7 : 0] op);
    begin
      gm2 = {op[6 : 0], 1'b0} ^ (8'h1b & {8{op[7]}});
    end
  endfunction // gm2

  function [7 : 0] gm3(input [7 : 0] op);
    begin
      gm3 = gm2(op) ^ op;
    end
  endfunction // gm3

  function [7 : 0] gm4(input [7 : 0] op);
    begin
      gm4 = gm2(gm2(op));
    end
  endfunction // gm4

  function [7 : 0] gm8(input [7 : 0] op);
    begin
      gm8 = gm2(gm4(op));
    end
  endfunction // gm8

  function [7 : 0] gm9(input [7 : 0] op);
    begin
      gm9 = gm8(op) ^ op;
    end
  endfunction // gm09

  function [7 : 0] gm11(input [7 : 0] op);
    begin
      gm11 = gm8(op) ^ gm2(op) ^ op;
    end
  endfunction // gm11

  function [7 : 0] gm13(input [7 : 0] op);
    begin
      gm13 = gm8(op) ^ gm4(op) ^ op;
    end
  endfunction // gm13

  function [7 : 0] gm14(input [7 : 0] op);
    begin
      gm14 = gm8(op) ^ gm4(op) ^ gm2(op);
    end
  endfunction // gm14

     
    
endmodule