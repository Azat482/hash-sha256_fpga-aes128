`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2017 11:40:35
// Design Name: 
// Module Name: AES_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module aes128_top_tb();
    
    localparam T = 10;
    reg clk, reset;
    wire [127:0] test_key;
    wire [1407:0] expanded_key;
    wire [127:0] test_input_message;
    wire [127:0] test_output_message;
    wire mode;
	
    reg [127:0] buff_test_key;
    reg [127:0] buff_test_input_message;
    reg [127:0] buff_mode;

    aes128_top i_aes128_top(
	    . clk(clk),
	    . reset(reset),
	    . key(test_key),
	    . mode(mode),
	    . input_message(test_input_message),
	    . output_message(test_output_message));
	

    //always
    //begin
      //  clk = 1'b1;
      //  #(T/2);
      //  clk = 1'b0;
      //  #(T/2);
    //end
    
    //initial
    //begin
      //  reset = 1'b1;
      //  #(T/2);
      //  reset = 1'b0;
    //end


  initial begin
    clk = 0;
	  forever #10 clk = !clk;
  end
	
  initial begin
  	buff_test_key =  128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
 

	buff_test_input_message = 128'h32_43_f6_a8_88_5a_30_8d_31_31_98_a2_e0_37_07_34;
  	buff_mode = 1'b0;
  end
    
   
  reg [7:0] counter;
  initial counter = 8'd1;
  
  always@(test_output_message)begin
	#20
	//#40
  case(counter)
  	8'd1: begin
  		buff_test_key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
  		buff_test_input_message = 128'h39_25_84_1d_02_dc_09_fb_dc_11_85_97_19_6a_0b_32;
  		buff_mode = 1'b1;
  	end
  	8'd2: begin
  		buff_test_key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
  		buff_test_input_message = 128'h32_43_f6_a8_88_5a_30_8d_31_31_98_a2_e0_37_07_34;
  		buff_mode = 1'b0;
  	end
  	8'd3: begin
  		buff_test_key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
  		buff_test_input_message = 128'h39_25_84_1d_02_dc_09_fb_dc_11_85_97_19_6a_0b_32;
  		buff_mode = 1'b1;
  	end
  	default: begin
  	end
  endcase
  counter = counter + 8'd1;
  end 
   

   assign test_key = buff_test_key;
   assign test_input_message = buff_test_input_message;
   assign mode = buff_mode;
endmodule