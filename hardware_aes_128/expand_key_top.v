

module expand_key_top(
    input wire clk,
    input wire reset,
    input wire [127:0] key,
    output wire[1407:0] expanded_key
	);
	
	parameter    rcon_index_1 = 8'h01;
	parameter    rcon_index_2 = 8'h02;
	parameter    rcon_index_3 = 8'h03;
	parameter    rcon_index_4 = 8'h04;
	parameter    rcon_index_5 = 8'h05;
	parameter    rcon_index_6 = 8'h06;
	parameter    rcon_index_7 = 8'h07;
	parameter    rcon_index_8 = 8'h08;
	parameter    rcon_index_9 = 8'h09;
	parameter    rcon_index_10 = 8'h0a;
	
	reg [7:0] counter = 8'd0;
	reg [127:0] buff_rkey_in_reg;
	reg [127:0] buff_rkey_out_reg;
	reg [1407:0] expanded_key_reg;
	reg [7:0] rcon_reg;
	
	wire [127:0] buff_rkey_in;
	wire [127:0] buff_rkey_out;
	wire [7:0] rcon;
	
	always @(posedge clk) begin
		
		case(counter)
			8'd0:begin
				rcon_reg = rcon_index_1;
				buff_rkey_in_reg = key[127:0];
				expanded_key_reg[127:0] = key[127:0];
				counter = counter + 8'd1;
			end
			8'd1:begin
				rcon_reg = rcon_index_2;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[255:128] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd2:begin
				rcon_reg = rcon_index_3;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[383:256] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd3:begin
				rcon_reg = rcon_index_4;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[511:384] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd4:begin
				rcon_reg = rcon_index_5;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[639:512] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd5:begin
				rcon_reg = rcon_index_6;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[767:640] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd6:begin
				rcon_reg = rcon_index_7;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[895:768] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd7:begin
				rcon_reg = rcon_index_8;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[1023:896] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd8:begin
				rcon_reg = rcon_index_9;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[1151:1024] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd9:begin
				rcon_reg = rcon_index_10;
				buff_rkey_in_reg = buff_rkey_out[127:0];
				expanded_key_reg[1279:1152] = buff_rkey_out[127:0];
				counter = counter + 8'd1;
			end
			8'd10:begin
				expanded_key_reg[1407:1280] = buff_rkey_out[127:0];
				counter = 8'd0;
			end
		endcase
	end
	
	expand_key_core i_expand_key_core(
	    . clk(clk),
	    . reset(reset),
	    . key_in(buff_rkey_in),
	    . rcon_index_in(rcon),
	    . expanded_key_out(buff_rkey_out));
		 
    
assign buff_rkey_in = buff_rkey_in_reg; 
assign rcon = rcon_reg;	 
assign expanded_key = expanded_key_reg;
  
endmodule