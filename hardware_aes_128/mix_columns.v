


module mix_columns(
    input wire clk,
    input wire reset,    
    input wire [127:0] state_mc_in,
    output wire [127:0] state_mc_out
	);
	
		
	//Internal logic
	reg [127:0] temp; 
	reg [127:0] state_mc_out_reg; 
	reg [127:0] state_mc_out_next;
	
	
	always @*
    begin
    	//Combinational logic
    	state_mc_out_next = state_mc_in;
    	//Mix Columns
        temp[127:120] =  mul_by_2(state_mc_out_next[127:120]) ^ mul_by_3(state_mc_out_next[119:112]) ^ state_mc_out_next[111:104] ^ state_mc_out_next[103:96]; //+       
        temp[119:112] = state_mc_out_next[127:120] ^ mul_by_2(state_mc_out_next[119:112]) ^ mul_by_3(state_mc_out_next[111:104]) ^ state_mc_out_next[103:96]; //+
        temp[111:104] = state_mc_out_next[127:120] ^ state_mc_out_next[119:112] ^ mul_by_2(state_mc_out_next[111:104]) ^ mul_by_3(state_mc_out_next[103:96]); //+
        temp[103:96] = mul_by_3(state_mc_out_next[127:120]) ^ state_mc_out_next[119:112] ^ state_mc_out_next[111:104] ^ mul_by_2(state_mc_out_next[103:96]); //+
    
        temp[95:88] = mul_by_2(state_mc_out_next[95:88]) ^ mul_by_3(state_mc_out_next[87:80]) ^ state_mc_out_next[79:72] ^ state_mc_out_next[71:64]; //+
        temp[87:80] = state_mc_out_next[95:88] ^ mul_by_2(state_mc_out_next[87:80]) ^ mul_by_3(state_mc_out_next[79:72]) ^ state_mc_out_next[71:64]; //+
        temp[79:72] = state_mc_out_next[95:88] ^ state_mc_out_next[87:80] ^ mul_by_2(state_mc_out_next[79:72])^mul_by_3(state_mc_out_next[71:64]);   //+
        temp[71:64] = mul_by_3(state_mc_out_next[95:88]) ^ state_mc_out_next[87:80] ^ state_mc_out_next[79:72] ^ mul_by_2(state_mc_out_next[71:64]); //+
    
        temp[63:56] = mul_by_2(state_mc_out_next[63:56]) ^ mul_by_3(state_mc_out_next[55:48]) ^ state_mc_out_next[47:40] ^ state_mc_out_next[39:32]; //+
        temp[55:48] = state_mc_out_next[63:56] ^ mul_by_2(state_mc_out_next[55:48]) ^ mul_by_3(state_mc_out_next[47:40]) ^ state_mc_out_next[39:32]; //+
        temp[47:40] = state_mc_out_next[63:56] ^ state_mc_out_next[55:48] ^ mul_by_2(state_mc_out_next[47:40])^mul_by_3(state_mc_out_next[39:32]);  //+
        temp[39:32] = mul_by_3(state_mc_out_next[63:56]) ^ state_mc_out_next[55:48] ^ state_mc_out_next[47:40] ^ mul_by_2(state_mc_out_next[39:32]); //+
        
        temp[31:24] = mul_by_2(state_mc_out_next[31:24]) ^ mul_by_3(state_mc_out_next[23:16]) ^ state_mc_out_next[15:8] ^ state_mc_out_next[7:0]; //+
        temp[23:16] = state_mc_out_next[31:24] ^ mul_by_2(state_mc_out_next[23:16]) ^ mul_by_3(state_mc_out_next[15:8]) ^ state_mc_out_next[7:0]; //+
        temp[15:8] = state_mc_out_next[31:24] ^ state_mc_out_next[23:16] ^ mul_by_2(state_mc_out_next[15:8]) ^ mul_by_3(state_mc_out_next[7:0]);  //+
        temp[7:0] = mul_by_3(state_mc_out_next[31:24]) ^ state_mc_out_next[23:16] ^ state_mc_out_next[15:8] ^ mul_by_2(state_mc_out_next[7:0]);   //+
        
        state_mc_out_next[127:0] = temp[127:0];

    end
    
    assign state_mc_out = state_mc_out_next;
	
	
    function [7 : 0] mul_by_2(input [7 : 0] op);
    begin
        mul_by_2 = {op[6 : 0], 1'b0} ^ (8'h1b & {8{op[7]}});
    end
    endfunction // gm2

    function [7 : 0] mul_by_3(input [7 : 0] op);
    begin
        mul_by_3 = mul_by_2(op) ^ op;
    end
    endfunction // gm3   
	
endmodule

