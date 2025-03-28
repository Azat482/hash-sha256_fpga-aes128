


module decrypt_top(
    input wire clk,
    input wire reset,    
    input wire [127:0] key,
    input wire [127:0] round1_key, 
    input wire [127:0] round2_key, 
    input wire [127:0] round3_key, 
    input wire [127:0] round4_key, 
    input wire [127:0] round5_key,
	 input wire [127:0] round6_key, 
	 input wire [127:0] round7_key, 
	 input wire [127:0] round8_key, 
	 input wire [127:0] round9_key, 
	 input wire [127:0] round10_key, 
    input wire [127:0] cipher_data,
    output wire [127:0] decrypted_plain_data
	);
	
	wire [127:0] dec_state_i_r_out;
	wire [127:0] dec_buff_state_in, dec_buff_state_out;
	wire [127:0] dec_state_ark_in, dec_state_ark_out;
	wire [127:0] buff_round_key;

	reg [127:0] dec_buff_state_in_reg;
	reg [127:0] dec_state_ark_in_reg, dec_state_ark_out_reg;
	reg [127:0] buff_round_key_reg;
	reg [7:0] counter;

	initial counter = 8'h0;

	always @(dec_state_ark_out)begin
		dec_state_ark_out_reg = dec_state_ark_out;
	end 
	
	always @(posedge clk)
    begin
            
	case(counter)
		8'h0: begin
			dec_buff_state_in_reg = dec_state_i_r_out;
			buff_round_key_reg = round9_key;
			counter = counter + 8'h1;
		end
		8'h1: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round8_key;
			counter = counter + 8'h1;
		end
		8'h2: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round7_key;
			counter = counter + 8'h1;
		end
		8'h3: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round6_key;
			counter = counter + 8'h1;
		end	
		8'h4: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round5_key;
			counter = counter + 8'h1;
		end	
		8'h5: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round4_key;
			counter = counter + 8'h1;
		end	
		8'h6: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round3_key;
			counter = counter + 8'h1;
		end	
		8'h7: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round2_key;
			counter = counter + 8'h1;
		end	
		8'h8: begin
			dec_buff_state_in_reg = dec_buff_state_out;
			buff_round_key_reg = round1_key;
			counter = counter + 8'h1;
		end
		8'h9: begin
			dec_state_ark_in_reg = dec_buff_state_out;
			buff_round_key_reg = key;
			counter = counter + 8'h1;
		end	
		default: counter = 8'h0;	
	endcase
    end
	
    
	assign buff_round_key = buff_round_key_reg;
	assign decrypted_plain_data = dec_state_ark_out_reg;
	assign dec_buff_state_in = dec_buff_state_in_reg;
	assign dec_state_ark_in = dec_state_ark_in_reg;

	decrypt_initial_round i_decrypt_initial_round(
			. clk(clk), 
			. reset(reset),
			. round_key(round10_key),
			. state_in(cipher_data),
			. state_round(dec_state_i_r_out));

	decrypt_round decrypt_round_2_10(
			. clk(clk),
			. reset(reset),
			. round_key(buff_round_key),
			. dec_state_in(dec_buff_state_in),
			. dec_state_round(dec_buff_state_out));
    
   add_round_key i_add_round_key(
	      . clk(clk),
		   . reset(reset),	    
	      . round_key(key),
	      . state_ark_in(dec_state_ark_in),
	      . state_ark_out(dec_state_ark_out));
    
	endmodule