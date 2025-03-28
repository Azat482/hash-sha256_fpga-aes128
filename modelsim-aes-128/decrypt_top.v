


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
    input wire [127:0] cipher_text,
    output wire [127:0] decrypted_plain_text
	);
	
	/*wire [127:0] dec_state_round1_out;
	wire [127:0] dec_state_round2_in, dec_state_round2_out;
	wire [127:0] dec_state_round3_in, dec_state_round3_out;
	wire [127:0] dec_state_round4_in, dec_state_round4_out;
	wire [127:0] dec_state_round5_in, dec_state_round5_out;
	wire [127:0] dec_state_round6_in, dec_state_round6_out;
	wire [127:0] dec_state_round7_in, dec_state_round7_out;
	wire [127:0] dec_state_round8_in, dec_state_round8_out;
	wire [127:0] dec_state_round9_in, dec_state_round9_out;
	wire [127:0] dec_state_round10_in, dec_state_round10_out;
	wire [127:0] dec_add_key_out;
	
		
	reg [127:0] dec_state_round1_reg, dec_state_round1_next;
	reg [127:0] dec_state_round2_reg, dec_state_round2_next;
	reg [127:0] dec_state_round3_reg, dec_state_round3_next;
	reg [127:0] dec_state_round4_reg, dec_state_round4_next;
	reg [127:0] dec_state_round5_reg, dec_state_round5_next;
	reg [127:0] dec_state_round6_reg, dec_state_round6_next;
	reg [127:0] dec_state_round7_reg, dec_state_round7_next;
	reg [127:0] dec_state_round8_reg, dec_state_round8_next;
	reg [127:0] dec_state_round9_reg, dec_state_round9_next;
	reg [127:0] dec_state_round10_reg, dec_state_round10_next;*/
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
            /*dec_state_round1_reg <= dec_state_round1_next;
	    dec_state_round2_reg <= dec_state_round2_next;
	    dec_state_round3_reg <= dec_state_round3_next;
	    dec_state_round4_reg <= dec_state_round4_next;
	    dec_state_round5_reg <= dec_state_round5_next;
	    dec_state_round6_reg <= dec_state_round6_next;
	    dec_state_round7_reg <= dec_state_round7_next;
	    dec_state_round8_reg <= dec_state_round8_next;
	    dec_state_round9_reg <= dec_state_round9_next;
	    dec_state_round10_reg <= dec_state_round10_next;*/
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
	
	/*always @*
    begin
    	//Combinational logic
		dec_state_round1_next = dec_state_round1_out;
	   	dec_state_round2_next = dec_state_round2_out;
	    dec_state_round3_next = dec_state_round3_out;
	    dec_state_round4_next = dec_state_round4_out;
	    dec_state_round5_next = dec_state_round5_out;
	    dec_state_round6_next = dec_state_round6_out;
	    dec_state_round7_next = dec_state_round7_out;
	    dec_state_round8_next = dec_state_round8_out;
	    dec_state_round9_next = dec_state_round9_out;
	    dec_state_round10_next = dec_state_round10_out;
    end*/
    
    /*assign dec_state_round2_in = dec_state_round1_reg;
    assign dec_state_round3_in = dec_state_round2_reg;
    assign dec_state_round4_in = dec_state_round3_reg;
	assign dec_state_round5_in = dec_state_round4_reg;
    assign dec_state_round6_in = dec_state_round5_reg;
    assign dec_state_round7_in = dec_state_round6_reg;
    assign dec_state_round8_in = dec_state_round7_reg;
    assign dec_state_round9_in = dec_state_round8_reg;
    assign dec_state_round10_in = dec_state_round9_reg;

	assign decrypted_plain_text = dec_add_key_out;*/
    
	assign buff_round_key = buff_round_key_reg;
	assign decrypted_plain_text = dec_state_ark_out_reg;
	assign dec_buff_state_in = dec_buff_state_in_reg;
	assign dec_state_ark_in = dec_state_ark_in_reg;

	decrypt_initial_round i_decrypt_initial_round(
			. clk(clk), 
			. reset(reset),
			. round_key(round10_key),
			. state_in(cipher_text),
			. state_round(dec_state_i_r_out));

	decrypt_round decrypt_round_2_10(
			. clk(clk),
			. reset(reset),
			. round_key(buff_round_key),
			. dec_state_in(dec_buff_state_in),
			. dec_state_round(dec_buff_state_out));
    
    /*decrypt_round i_decrypt_round_2(
		. clk(clk), 
		. reset(reset),
		. round_key(round9_key),
		. dec_state_in(dec_state_round2_in),
		. dec_state_round(dec_state_round2_out));
    
    decrypt_round i_decrypt_round_3(
		. clk(clk), 
		. reset(reset),
		. round_key(round8_key),
		. dec_state_in(dec_state_round3_in),
		. dec_state_round(dec_state_round3_out));
    
    decrypt_round i_decrypt_round_4(
		. clk(clk), 
		. reset(reset),
		. round_key(round7_key),
		. dec_state_in(dec_state_round4_in),
		. dec_state_round(dec_state_round4_out));
    
    decrypt_round i_decrypt_round_5(
		. clk(clk),
		. reset(reset),		
		. round_key(round6_key),
		. dec_state_in(dec_state_round5_in),
		. dec_state_round(dec_state_round5_out));
    
    decrypt_round i_decrypt_round_6(
		. clk(clk), 
		. reset(reset),		
		. round_key(round5_key),
		. dec_state_in(dec_state_round6_in),
		. dec_state_round(dec_state_round6_out));
    
    decrypt_round i_decrypt_round_7(
		. clk(clk), 
		. reset(reset),
		. round_key(round4_key),
		. dec_state_in(dec_state_round7_in),
		. dec_state_round(dec_state_round7_out));
    
    decrypt_round i_decrypt_round_8(
		. clk(clk), 
		. reset(reset),		
		. round_key(round3_key),
		. dec_state_in(dec_state_round8_in),
		. dec_state_round(dec_state_round8_out));
    
    decrypt_round i_decrypt_round_9(
		. clk(clk),
		. reset(reset),		
		. round_key(round2_key),
		. dec_state_in(dec_state_round9_in),
		. dec_state_round(dec_state_round9_out));
    
    decrypt_round i_decrypt_round_10(
		. clk(clk),
		. reset(reset),		
		. round_key(round1_key),
		. dec_state_in(dec_state_round10_in),
		. dec_state_round(dec_state_round10_out));*/
    
    add_round_key i_add_round_key(
	    . clk(clk),
		. reset(reset),	    
	    . round_key(key),
	    . state_ark_in(dec_state_ark_in),
	    . state_ark_out(dec_state_ark_out));
    
	endmodule