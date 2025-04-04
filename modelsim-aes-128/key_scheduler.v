


module key_scheduler(
	input wire clk,
	input wire reset,
	input wire[1407:0] expanded_key,
	output wire [127:0] round1_key,
	output wire [127:0] round2_key,
	output wire [127:0] round3_key,
	output wire [127:0] round4_key,
	output wire [127:0] round5_key,
	output wire [127:0] round6_key,
	output wire [127:0] round7_key,	
	output wire [127:0] round8_key,
	output wire [127:0] round9_key,
	output wire [127:0] round10_key
	);
	
	//Internal logic
	reg [1407:0] expanded_key_temp;
	reg [127:0] round1_key_next;
	reg [127:0] round2_key_next;
	reg [127:0] round3_key_next;
	reg [127:0] round4_key_next;
	reg [127:0] round5_key_next;
	reg [127:0] round6_key_next;
	reg [127:0] round7_key_next;
	reg [127:0] round8_key_next;
	reg [127:0] round9_key_next;
	reg [127:0] round10_key_next;
	
	
	always @*
    begin
    	//Combinational logic
		expanded_key_temp[1407:0] = expanded_key[1407:0];
	    
	    round1_key_next = expanded_key_temp[255:128];
	    round2_key_next = expanded_key_temp[383:256];
	    round3_key_next = expanded_key_temp[511:384];
	    round4_key_next = expanded_key_temp[639:512];
	    round5_key_next = expanded_key_temp[767:640];
	    round6_key_next = expanded_key_temp[895:768];
	    round7_key_next = expanded_key_temp[1023:896];
	    round8_key_next = expanded_key_temp[1151:1024];
	    round9_key_next = expanded_key_temp[1279:1152];
	    round10_key_next = expanded_key_temp[1407:1280];
	    
    end
    
    assign round1_key = round1_key_next;
    assign round2_key = round2_key_next;
    assign round3_key = round3_key_next;
    assign round4_key = round4_key_next;
    assign round5_key = round5_key_next;
    assign round6_key = round6_key_next;
    assign round7_key = round7_key_next;
    assign round8_key = round8_key_next;
    assign round9_key = round9_key_next;
    assign round10_key = round10_key_next;
    
endmodule