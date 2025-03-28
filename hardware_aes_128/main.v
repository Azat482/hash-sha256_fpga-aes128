`define ENABLE_CLOCK1
`define ENABLE_CLOCK2
`define ENABLE_HEX0
`define ENABLE_HEX1
`define ENABLE_HEX2
`define ENABLE_HEX3
`define ENABLE_HEX4
`define ENABLE_HEX5
`define ENABLE_GPIO
`define ENABLE_SW

module main(

//////////// CLOCK 1: 3.3-V LVTTL //////////
`ifdef ENABLE_CLOCK1
	input 		          		MAX10_CLK1_50,
`endif

`ifdef ENABLE_CLOCK2
	input 		          		MAX10_CLK2_50,
`endif

	//////////// SEG7: 3.3-V LVTTL //////////
`ifdef ENABLE_HEX0
	output		     [7:0]		HEX0,
`endif
`ifdef ENABLE_HEX1
	output		     [7:0]		HEX1,
`endif
`ifdef ENABLE_HEX2
	output		     [7:0]		HEX2,
`endif
`ifdef ENABLE_HEX3
	output 		     [7:0]		HEX3,
`endif
`ifdef ENABLE_HEX4
	output		     [7:0]		HEX4,
`endif
`ifdef ENABLE_HEX5
	output		     [7:0]		HEX5,
`endif
 
 //switches 
`ifdef ENABLE_SW
	input 		     [9:0]		SW,
`endif

output clk_stp,
output [7:0] signaltap_rx_out,
output [127:0] signaltap_output_message_out,

	//////////// GPIO, GPIO connect to GPIO Default: 3.3-V LVTTL //////////
`ifdef ENABLE_GPIO
	inout 		    [35:0]		GPIO
`endif
);
  
parameter ClkFrequency = 50000000;
parameter Baud = 115200;


//NEW CLOCK 
reg [3:0] my_clock = 4'd0;
always @(posedge MAX10_CLK1_50)begin
	my_clock = my_clock + 1;
end

assign clk_stp=my_clock[3];


//receiver
wire RxD;
wire RxD_data_ready;
wire [7:0] RxD_data;

async_receiver aes_rx_uart(
	.clk(MAX10_CLK1_50),
	.RxD(RxD),
	.RxD_data_ready(RxD_data_ready),
	.RxD_data(RxD_data)
);


//transmitter
wire TxD_start;
wire [7:0] TxD_data;
wire TxD;
wire TxD_busy;

reg [7:0] TxD_data_reg;
reg TxD_start_reg;

async_transmitter aes_tx_uart(
	.clk(MAX10_CLK1_50),
	.TxD_start(TxD_start),
	.TxD_data(TxD_data),
	.TxD(TxD),
	.TxD_busy(TxD_busy)
);

defparam aes_tx_uart.ClkFrequency=ClkFrequency;
defparam aes_tx_uart.Baud=Baud;
defparam aes_rx_uart.ClkFrequency=ClkFrequency;
defparam aes_rx_uart.Baud=Baud;

//AES
wire mode;
wire [127:0] key;
wire [127:0] input_message;
wire [127:0] output_message;

reg mode_reg;
reg [127:0] key_reg;

aes128_top aes(
	.clk(MAX10_CLK1_50),
	.reset(1'b0),
	.mode(mode),
	.key(key),
	.input_message(input_message),
	.output_message(output_message)
);

reg [7:0] signal_tap_data_rx_reg;
reg [127:0] signaltap_output_message_reg;
reg [31:0] counter = 32'd0; 
reg [7:0] r_data_counter = 8'd0;
reg [7:0] t_counter = 8'd0;
reg [7:0] aes_counter = 8'd0;
reg [127:0] max_length_reg = 8'd63;
reg [127:0] data_buff_reg;
reg aes_start_flag = 1'b0;
reg aes_read_flag = 1'b0;
always @(posedge MAX10_CLK1_50)begin
	signaltap_output_message_reg = output_message[127:0];
	if(RxD_data_ready)begin
		signal_tap_data_rx_reg <= RxD_data;
		if(counter == 32'd15)begin
			mode_reg <= RxD_data[7];
		end
		if(counter >= 32'd16 && counter <= 32'd31) begin
			case(counter)
				32'd16: key_reg[127:120] <= RxD_data;
				32'd17: key_reg[119:112] <= RxD_data;
				32'd18: key_reg[111:104] <= RxD_data;
				32'd19: key_reg[103:96] <= RxD_data;
				32'd20: key_reg[95:88] <= RxD_data;
				32'd21: key_reg[87:80] <= RxD_data;
				32'd22: key_reg[79:72] <= RxD_data;
				32'd23: key_reg[71:64] <= RxD_data;
				32'd24: key_reg[63:56] <= RxD_data;
				32'd25: key_reg[55:48] <= RxD_data;
				32'd26: key_reg[47:40] <= RxD_data;
				32'd27: key_reg[39:32] <= RxD_data;
				32'd28: key_reg[31:24] <= RxD_data;
				32'd29: key_reg[23:16] <= RxD_data;
				32'd30: key_reg[15:8] <= RxD_data;
				32'd31: key_reg[7:0] <= RxD_data;
				default: 
					begin 
						//
					end
			endcase
		end
		
		if(counter >= 32'd32 && counter <= 32'd47)begin
			case(counter)
				32'd32: max_length_reg[127:120] <= RxD_data;
				32'd33: max_length_reg[119:112] <= RxD_data;
				32'd34: max_length_reg[111:104] <= RxD_data;
				32'd35: max_length_reg[103:96] <= RxD_data;
				32'd36: max_length_reg[95:88] <= RxD_data;
				32'd37: max_length_reg[87:80] <= RxD_data;
				32'd38: max_length_reg[79:72] <= RxD_data;
				32'd39: max_length_reg[71:64] <= RxD_data;
				32'd40: max_length_reg[63:56] <= RxD_data;
				32'd41: max_length_reg[55:48] <= RxD_data;
				32'd42: max_length_reg[47:40] <= RxD_data;
				32'd43: max_length_reg[39:32] <= RxD_data;
				32'd44: max_length_reg[31:24] <= RxD_data;
				32'd45: max_length_reg[23:16] <= RxD_data;
				32'd46: max_length_reg[15:8] <= RxD_data;
				32'd47: max_length_reg[7:0] <= RxD_data;
			endcase
		end
		//RECEIVING INPUT MESSAGE DATA 
		if(counter >= 32'd48 && counter < max_length_reg[31:0])begin
			case(r_data_counter)
				8'd0: data_buff_reg[127:120] <= RxD_data;
				8'd1: data_buff_reg[119:112] <= RxD_data;
				8'd2: data_buff_reg[111:104] <= RxD_data;
				8'd3: data_buff_reg[103:96] <= RxD_data;
				8'd4: data_buff_reg[95:88] <= RxD_data;
				8'd5: data_buff_reg[87:80] <= RxD_data;
				8'd6: data_buff_reg[79:72] <= RxD_data;
				8'd7: data_buff_reg[71:64] <= RxD_data;
				8'd8: data_buff_reg[63:56] <= RxD_data;
				8'd9: data_buff_reg[55:48] <= RxD_data;
				8'd10: data_buff_reg[47:40] <= RxD_data;
				8'd11: data_buff_reg[39:32] <= RxD_data;
				8'd12: data_buff_reg[31:24] <= RxD_data;
				8'd13: data_buff_reg[23:16] <= RxD_data;
				8'd14: data_buff_reg[15:8] <= RxD_data;
				8'd15: data_buff_reg[7:0] <= RxD_data;
				default: begin end
			endcase
			r_data_counter = r_data_counter + 8'd1;
			//after receiving the full block AES start working
			if(r_data_counter == 8'd16)begin
				r_data_counter <= 8'd0;
				aes_start_flag <= 8'd1;
			end
		end
		//max_length_reg <= 8'd63;
		//if(counter <= max_length_reg) begin
		//	counter <= counter + 8'd1;
		//end
		//if (counter >= 8'd64) begin
		//	counter <= 8'd0;
		//	input_message_reg <= data_buff_reg;
		//	aes_start_flag <= 1'b1;
		//end
		counter = counter + 32'd1;
		if(counter == max_length_reg[31:0])begin
			counter <= 32'd0;
		   //input_message_reg <= data_buff_reg;
		   //aes_start_flag <= 1'b1;
		end
	end
	
	if(aes_start_flag)begin
		if(aes_counter < 8'd20)begin   //after 20 clocks
			aes_counter <= aes_counter + 8'd1;
		end
		else begin
			aes_read_flag <= 1'b1;
			//output_message_reg <= output_message;
		end
	end
	
	if(aes_read_flag && !TxD_busy)begin
		case(t_counter)
			8'd0: begin
				TxD_data_reg <= output_message[127:120];
				TxD_start_reg <= 1'b1;
			end
			8'd2: begin
				TxD_data_reg <= output_message[119:112];
				TxD_start_reg <= 1'b1;
			end
			8'd4: begin
				TxD_data_reg <= output_message[111:104];
				TxD_start_reg <= 1'b1;
			end
			8'd6: begin
				TxD_data_reg <= output_message[103:96];
				TxD_start_reg <= 1'b1;
			end
			8'd8: begin
				TxD_data_reg <= output_message[95:88];
				TxD_start_reg <= 1'b1;
			end
			8'd10: begin
				TxD_data_reg <= output_message[87:80];
				TxD_start_reg <= 1'b1;
			end
			8'd12: begin
				TxD_data_reg <= output_message[79:72];
				TxD_start_reg <= 1'b1;
			end
			8'd14: begin
				TxD_data_reg <= output_message[71:64];
				TxD_start_reg <= 1'b1;
			end
			8'd16: begin
				TxD_data_reg <= output_message[63:56];
				TxD_start_reg <= 1'b1;
			end
			8'd18: begin
				TxD_data_reg <= output_message[55:48];
				TxD_start_reg <= 1'b1;
			end
			8'd20: begin
				TxD_data_reg <= output_message[47:40];
				TxD_start_reg <= 1'b1;
			end
			8'd22: begin
				TxD_data_reg <= output_message[39:32];
				TxD_start_reg <= 1'b1;
			end
			8'd24: begin
				TxD_data_reg <= output_message[31:24];
				TxD_start_reg <= 1'b1;
			end
			8'd26: begin
				TxD_data_reg <= output_message[23:16];
				TxD_start_reg <= 1'b1;
			end
			8'd28: begin
				TxD_data_reg <= output_message[15:8];
				TxD_start_reg <= 1'b1;
			end
			8'd30: begin
				TxD_data_reg <= output_message[7:0];
				TxD_start_reg <= 1'b1;
			end
			8'd1, 8'd3, 8'd5, 8'd7, 8'd9, 8'd11, 8'd13, 8'd15, 8'd17, 8'd19, 8'd21, 8'd23, 8'd25, 8'd27, 8'd29, 8'd31: 
			begin
				TxD_start_reg <= 1'b0;
			end
			default: begin
			
			end
		endcase
	
		t_counter <= t_counter + 8'd1;
		if(t_counter == 8'd32)begin
			t_counter <= 8'd0;
			aes_start_flag <= 1'b0;
			aes_read_flag <= 1'b0;
			aes_counter <= 8'd0;
		end
	end
	
end

//RxD
assign RxD = GPIO[34];

//TxD
assign GPIO[35] = TxD; 
assign TxD_data = TxD_data_reg;
assign TxD_start = TxD_start_reg;
assign signaltap_rx_out = signal_tap_data_rx_reg;
assign signaltap_output_message_out = signaltap_output_message_reg;
//AES

assign mode = mode_reg;
assign key = key_reg;
assign input_message = data_buff_reg;
  
//HEX0-5 AES128
assign HEX0 = 8'b10000000; //8
assign HEX1 = 8'b10100100; //2
assign HEX2 = 8'b11111001; //1
assign HEX3 = 8'b00010010; //S.
assign HEX4 = 8'b10000110; //E
assign HEX5 = 8'b10001000; //A

endmodule