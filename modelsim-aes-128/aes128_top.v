


module aes128_top(
    input wire clk,
    input wire reset,
    
    input wire mode,
    input wire [127:0] key,    
    input wire [127:0] input_message,
     
    output wire [127:0] output_message   
	);
	
	reg [3:0] my_clock = 4'd0;
	always @(posedge clk) begin
		my_clock = my_clock + 1;
	end
	
	
	wire [127:0] round1_key, round2_key, round3_key, round4_key, round5_key,
				 round6_key, round7_key, round8_key, round9_key, round10_key;
	wire [1407:0] expanded_key_out;	
	wire [127:0] cipher_message_out;
	wire [127:0] decrypted_message_out;
	
	reg [127:0] output_message_reg;
	
    
    always @(cipher_message_out, decrypted_message_out)
    begin
		$display("====================================");
		$display("initial cipher key: %h", key);
		$display("round key 1: %h", round1_key);
		$display("round key 2: %h", round2_key);
		$display("round key 3: %h", round3_key);
		$display("round key 4: %h", round4_key);
		$display("round key 5: %h", round5_key);
		$display("round key 6: %h", round6_key);
		$display("round key 7: %h", round7_key);
		$display("round key 8: %h", round8_key);
		$display("round key 9: %h", round9_key);
		$display("round key 10: %h", round10_key);
		$display("====================================");
		if(mode == 1'b0)begin
			output_message_reg = cipher_message_out;
		end
		if(mode == 1'b1)begin
			output_message_reg = decrypted_message_out;
		end
    end
   
	//always @(cipher_message_out)begin
	//	output_message_reg = cipher_message_out;
	//end
    
    assign output_message = output_message_reg;
    
    
	expand_key_top i_expand_key_top(
		.clk(clk), 
	    .reset(reset),		
		.key(key),
		.expanded_key(expanded_key_out));

	key_scheduler i_key_scheduler(
	    . clk(clk),
	    . reset(reset),
	    . expanded_key(expanded_key_out),
	    . round1_key(round1_key),
	    . round2_key(round2_key),
	    . round3_key(round3_key),
	    . round4_key(round4_key),
	    . round5_key(round5_key),
	    . round6_key(round6_key),
	    . round7_key(round7_key),
	    . round8_key(round8_key),
	    . round9_key(round9_key),
	    . round10_key(round10_key));

	encrypt_top i_encrypt_top(
		. clk(clk),
		. reset(reset),
		. key(key), 
		. round1_key(round1_key),
	    . round2_key(round2_key),
	    . round3_key(round3_key),
	    . round4_key(round4_key),
	    . round5_key(round5_key),
	    . round6_key(round6_key),
	    . round7_key(round7_key),
	    . round8_key(round8_key),
	    . round9_key(round9_key),
	    . round10_key(round10_key),
		. plain_text(input_message), 
		. cipher_text(cipher_message_out));
    
    decrypt_top i_decrypt_top(
		. clk(clk),
		. reset(reset),
		. key(key), 
		. round1_key(round1_key),
	    . round2_key(round2_key),
	    . round3_key(round3_key),
	    . round4_key(round4_key),
	    . round5_key(round5_key),
	    . round6_key(round6_key),
	    . round7_key(round7_key),
	    . round8_key(round8_key),
	    . round9_key(round9_key),
	    . round10_key(round10_key),
		. cipher_text(input_message),
		. decrypted_plain_text(decrypted_message_out) );
	
	
endmodule 