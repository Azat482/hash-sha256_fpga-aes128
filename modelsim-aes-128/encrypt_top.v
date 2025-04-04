


module encrypt_top(
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
    input wire [127:0] plain_text,
    output wire [127:0] cipher_text
	);
	
	wire [127:0] enc_state_in;
	wire [127:0] enc_buff_state_in, enc_buff_state_out;
	wire [127:0] enc_state_f_r_in, enc_state_f_r_out;
	wire [127:0] buff_round_key;

	reg [127:0] enc_buff_state_in_reg;
	reg [127:0] enc_state_f_r_in_reg, enc_state_f_r_out_reg;
	reg [127:0] buff_round_key_reg;
   reg [7:0] counter = 8'h0;

	
	//always @(enc_state_in)begin
	//	enc_buff_state_in_reg = enc_state_in;
	//end

	always @(enc_state_f_r_out)begin
		enc_state_f_r_out_reg = enc_state_f_r_out;
	end

	always @(posedge clk)
    begin
        
	    case(counter)
		8'h0: begin
			enc_buff_state_in_reg = enc_state_in;
			buff_round_key_reg = round1_key;
			counter = counter + 8'h1;
		end
		8'h1: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round2_key;
			counter = counter + 8'h1;
		end
		8'h2: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round3_key;
			counter = counter + 8'h1;
		end
		8'h3: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round4_key;
			counter = counter + 8'h1;
		end
		8'h4: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round5_key;
			counter = counter + 8'h1;
		end
		8'h5: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round6_key;
			counter = counter + 8'h1;
		end
		8'h6: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round7_key;
			counter = counter + 8'h1;
		end
		8'h7: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round8_key;
			counter = counter + 8'h1;
		end
		8'h8: begin
			enc_buff_state_in_reg = enc_buff_state_out;
			buff_round_key_reg = round9_key;
			counter = counter + 8'h1;
		end
		8'h9: begin
			enc_state_f_r_in_reg = enc_buff_state_out;
			buff_round_key_reg = round10_key;
			counter = counter + 8'h1;
		end
		default: counter = 8'h0;
	    endcase
    end
	
   
    
    assign buff_round_key = buff_round_key_reg;
    assign enc_buff_state_in = enc_buff_state_in_reg;
    assign enc_state_f_r_in = enc_state_f_r_in_reg;
    assign cipher_text = enc_state_f_r_out_reg;

    add_round_key i_add_round_key(
	    . clk(clk), 
	    . reset(reset),
	    . round_key(key),
	    . state_ark_in(plain_text),
	    . state_ark_out(enc_state_in));
    
    encrypt_round encrypt_round_1_9(
            . clk(clk),
            . reset(reset),
            . round_key(buff_round_key),
            . enc_state_in(enc_buff_state_in),
            . enc_state_round(enc_buff_state_out));
    
     encrypt_final_round i_encrypt_final_round(
	    . clk(clk), 
	    . reset(reset),
		. round_key(round10_key),
		. state_in(enc_state_f_r_in),
		. state_round(enc_state_f_r_out));
    
	endmodule