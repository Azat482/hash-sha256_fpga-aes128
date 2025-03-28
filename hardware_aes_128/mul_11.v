

module mul_11(
	input [127:0] mul_11_in,
	output [127:0] mul_11_out
	);
	
	reg [127:0] mul_11_in_reg;
	reg [127:0] mul_11_out_reg;
	
	always @*
    begin
	    mul_11_in_reg = mul_11_in;
	    
	    mul_11_out_reg[7:0] = mul_by_11(mul_11_in_reg[7:0]);
	    mul_11_out_reg[15:8] = mul_by_11(mul_11_in_reg[15:8]);
	    mul_11_out_reg[23:16] = mul_by_11(mul_11_in_reg[23:16]);
	    mul_11_out_reg[31:24] = mul_by_11(mul_11_in_reg[31:24]);
	    mul_11_out_reg[39:32] = mul_by_11(mul_11_in_reg[39:32]);
	    mul_11_out_reg[47:40] = mul_by_11(mul_11_in_reg[47:40]);
	    mul_11_out_reg[55:48] = mul_by_11(mul_11_in_reg[55:48]);
	    mul_11_out_reg[63:56] = mul_by_11(mul_11_in_reg[63:56]);
	    mul_11_out_reg[71:64] = mul_by_11(mul_11_in_reg[71:64]);
	    mul_11_out_reg[79:72] = mul_by_11(mul_11_in_reg[79:72]);
	    mul_11_out_reg[87:80] = mul_by_11(mul_11_in_reg[87:80]);
	    mul_11_out_reg[95:88] = mul_by_11(mul_11_in_reg[95:88]);
	    mul_11_out_reg[103:96] = mul_by_11(mul_11_in_reg[103:96]);
	    mul_11_out_reg[111:104] = mul_by_11(mul_11_in_reg[111:104]);
	    mul_11_out_reg[119:112] = mul_by_11(mul_11_in_reg[119:112]);
	    mul_11_out_reg[127:120] = mul_by_11(mul_11_in_reg[127:120]);

	    
    end
    
    assign mul_11_out = mul_11_out_reg;

	function [7:0] mul_by_11;
    input [7:0] x;
 
    case (x)
      8'h00 : mul_by_11 = 8'h00;
      8'h01 : mul_by_11 = 8'h0B;
      8'h02 : mul_by_11 = 8'h16;
      8'h03 : mul_by_11 = 8'h1D;
      8'h04 : mul_by_11 = 8'h2C;
      8'h05 : mul_by_11 = 8'h27;
      8'h06 : mul_by_11 = 8'h3A;
      8'h07 : mul_by_11 = 8'h31;
      8'h08 : mul_by_11 = 8'h58;
      8'h09 : mul_by_11 = 8'h53;
      8'h0A : mul_by_11 = 8'h4E;
      8'h0B : mul_by_11 = 8'h45;
      8'h0C : mul_by_11 = 8'h74;
      8'h0D : mul_by_11 = 8'h7F;
      8'h0E : mul_by_11 = 8'h62;
      8'h0F : mul_by_11 = 8'h69;
      8'h10 : mul_by_11 = 8'hB0;
      8'h11 : mul_by_11 = 8'hBB;
      8'h12 : mul_by_11 = 8'hA6;
      8'h13 : mul_by_11 = 8'hAD;
      8'h14 : mul_by_11 = 8'h9C;
      8'h15 : mul_by_11 = 8'h97;
      8'h16 : mul_by_11 = 8'h8A;
      8'h17 : mul_by_11 = 8'h81;
      8'h18 : mul_by_11 = 8'hE8;
      8'h19 : mul_by_11 = 8'hE3;
      8'h1A : mul_by_11 = 8'hFE;
      8'h1B : mul_by_11 = 8'hF5;
      8'h1C : mul_by_11 = 8'hC4;
      8'h1D : mul_by_11 = 8'hCF;
      8'h1E : mul_by_11 = 8'hD2;
      8'h1F : mul_by_11 = 8'hD9;
      8'h20 : mul_by_11 = 8'h7B;
      8'h21 : mul_by_11 = 8'h70;
      8'h22 : mul_by_11 = 8'h6D;
      8'h23 : mul_by_11 = 8'h66;
      8'h24 : mul_by_11 = 8'h57;
      8'h25 : mul_by_11 = 8'h5C;
      8'h26 : mul_by_11 = 8'h41;
      8'h27 : mul_by_11 = 8'h4A;
      8'h28 : mul_by_11 = 8'h23;
      8'h29 : mul_by_11 = 8'h28;
      8'h2A : mul_by_11 = 8'h35;
      8'h2B : mul_by_11 = 8'h3E;
      8'h2C : mul_by_11 = 8'h0F;
      8'h2D : mul_by_11 = 8'h04;
      8'h2E : mul_by_11 = 8'h19;
      8'h2F : mul_by_11 = 8'h12;
      8'h30 : mul_by_11 = 8'hCB;
      8'h31 : mul_by_11 = 8'hC0;
      8'h32 : mul_by_11 = 8'hDD;
      8'h33 : mul_by_11 = 8'hD6;
      8'h34 : mul_by_11 = 8'hE7;
      8'h35 : mul_by_11 = 8'hEC;
      8'h36 : mul_by_11 = 8'hF1;
      8'h37 : mul_by_11 = 8'hFA;
      8'h38 : mul_by_11 = 8'h93;
      8'h39 : mul_by_11 = 8'h98;
      8'h3A : mul_by_11 = 8'h85;
      8'h3B : mul_by_11 = 8'h8E;
      8'h3C : mul_by_11 = 8'hBF;
      8'h3D : mul_by_11 = 8'hB4;
      8'h3E : mul_by_11 = 8'hA9;
      8'h3F : mul_by_11 = 8'hA2;
      8'h40 : mul_by_11 = 8'hF6;
      8'h41 : mul_by_11 = 8'hFD;
      8'h42 : mul_by_11 = 8'hE0;
      8'h43 : mul_by_11 = 8'hEB;
      8'h44 : mul_by_11 = 8'hDA;
      8'h45 : mul_by_11 = 8'hD1;
      8'h46 : mul_by_11 = 8'hCC;
      8'h47 : mul_by_11 = 8'hC7;
      8'h48 : mul_by_11 = 8'hAE;
      8'h49 : mul_by_11 = 8'hA5;
      8'h4A : mul_by_11 = 8'hB8;
      8'h4B : mul_by_11 = 8'hB3;
      8'h4C : mul_by_11 = 8'h82;
      8'h4D : mul_by_11 = 8'h89;
      8'h4E : mul_by_11 = 8'h94;
      8'h4F : mul_by_11 = 8'h9F;
      8'h50 : mul_by_11 = 8'h46;
      8'h51 : mul_by_11 = 8'h4D;
      8'h52 : mul_by_11 = 8'h50;
      8'h53 : mul_by_11 = 8'h5B;
      8'h54 : mul_by_11 = 8'h6A;
      8'h55 : mul_by_11 = 8'h61;
      8'h56 : mul_by_11 = 8'h7C;
      8'h57 : mul_by_11 = 8'h77;
      8'h58 : mul_by_11 = 8'h1E;
      8'h59 : mul_by_11 = 8'h15;
      8'h5A : mul_by_11 = 8'h08;
      8'h5B : mul_by_11 = 8'h03;
      8'h5C : mul_by_11 = 8'h32;
      8'h5D : mul_by_11 = 8'h39;
      8'h5E : mul_by_11 = 8'h24;
      8'h5F : mul_by_11 = 8'h2F;
      8'h60 : mul_by_11 = 8'h8D;
      8'h61 : mul_by_11 = 8'h86;
      8'h62 : mul_by_11 = 8'h9B;
      8'h63 : mul_by_11 = 8'h90;
      8'h64 : mul_by_11 = 8'hA1;
      8'h65 : mul_by_11 = 8'hAA;
      8'h66 : mul_by_11 = 8'hB7;
      8'h67 : mul_by_11 = 8'hBC;
      8'h68 : mul_by_11 = 8'hD5;
      8'h69 : mul_by_11 = 8'hDE;
      8'h6A : mul_by_11 = 8'hC3;
      8'h6B : mul_by_11 = 8'hC8;
      8'h6C : mul_by_11 = 8'hF9;
      8'h6D : mul_by_11 = 8'hF2;
      8'h6E : mul_by_11 = 8'hEF;
      8'h6F : mul_by_11 = 8'hE4;
      8'h70 : mul_by_11 = 8'h3D;
      8'h71 : mul_by_11 = 8'h36;
      8'h72 : mul_by_11 = 8'h2B;
      8'h73 : mul_by_11 = 8'h20;
      8'h74 : mul_by_11 = 8'h11;
      8'h75 : mul_by_11 = 8'h1A;
      8'h76 : mul_by_11 = 8'h07;
      8'h77 : mul_by_11 = 8'h0C;
      8'h78 : mul_by_11 = 8'h65;
      8'h79 : mul_by_11 = 8'h6E;
      8'h7A : mul_by_11 = 8'h73;
      8'h7B : mul_by_11 = 8'h78;
      8'h7C : mul_by_11 = 8'h49;
      8'h7D : mul_by_11 = 8'h42;
      8'h7E : mul_by_11 = 8'h5F;
      8'h7F : mul_by_11 = 8'h54;
      8'h80 : mul_by_11 = 8'hF7;
      8'h81 : mul_by_11 = 8'hFC;
      8'h82 : mul_by_11 = 8'hE1;
      8'h83 : mul_by_11 = 8'hEA;
      8'h84 : mul_by_11 = 8'hDB;
      8'h85 : mul_by_11 = 8'hD0;
      8'h86 : mul_by_11 = 8'hCD;
      8'h87 : mul_by_11 = 8'hC6;
      8'h88 : mul_by_11 = 8'hAF;
      8'h89 : mul_by_11 = 8'hA4;
      8'h8A : mul_by_11 = 8'hB9;
      8'h8B : mul_by_11 = 8'hB2;
      8'h8C : mul_by_11 = 8'h83;
      8'h8D : mul_by_11 = 8'h88;
      8'h8E : mul_by_11 = 8'h95;
      8'h8F : mul_by_11 = 8'h9E;
      8'h90 : mul_by_11 = 8'h47;
      8'h91 : mul_by_11 = 8'h4C;
      8'h92 : mul_by_11 = 8'h51;
      8'h93 : mul_by_11 = 8'h5A;
      8'h94 : mul_by_11 = 8'h6B;
      8'h95 : mul_by_11 = 8'h60;
      8'h96 : mul_by_11 = 8'h7D;
      8'h97 : mul_by_11 = 8'h76;
      8'h98 : mul_by_11 = 8'h1F;
      8'h99 : mul_by_11 = 8'h14;
      8'h9A : mul_by_11 = 8'h09;
      8'h9B : mul_by_11 = 8'h02;
      8'h9C : mul_by_11 = 8'h33;
      8'h9D : mul_by_11 = 8'h38;
      8'h9E : mul_by_11 = 8'h25;
      8'h9F : mul_by_11 = 8'h2E;
      8'hA0 : mul_by_11 = 8'h8C;
      8'hA1 : mul_by_11 = 8'h87;
      8'hA2 : mul_by_11 = 8'h9A;
      8'hA3 : mul_by_11 = 8'h91;
      8'hA4 : mul_by_11 = 8'hA0;
      8'hA5 : mul_by_11 = 8'hAB;
      8'hA6 : mul_by_11 = 8'hB6;
      8'hA7 : mul_by_11 = 8'hBD;
      8'hA8 : mul_by_11 = 8'hD4;
      8'hA9 : mul_by_11 = 8'hDF;
      8'hAA : mul_by_11 = 8'hC2;
      8'hAB : mul_by_11 = 8'hC9;
      8'hAC : mul_by_11 = 8'hF8;
      8'hAD : mul_by_11 = 8'hF3;
      8'hAE : mul_by_11 = 8'hEE;
      8'hAF : mul_by_11 = 8'hE5;
      8'hB0 : mul_by_11 = 8'h3C;
      8'hB1 : mul_by_11 = 8'h37;
      8'hB2 : mul_by_11 = 8'h2A;
      8'hB3 : mul_by_11 = 8'h21;
      8'hB4 : mul_by_11 = 8'h10;
      8'hB5 : mul_by_11 = 8'h1B;
      8'hB6 : mul_by_11 = 8'h06;
      8'hB7 : mul_by_11 = 8'h0D;
      8'hB8 : mul_by_11 = 8'h64;
      8'hB9 : mul_by_11 = 8'h6F;
      8'hBA : mul_by_11 = 8'h72;
      8'hBB : mul_by_11 = 8'h79;
      8'hBC : mul_by_11 = 8'h48;
      8'hBD : mul_by_11 = 8'h43;
      8'hBE : mul_by_11 = 8'h5E;
      8'hBF : mul_by_11 = 8'h55;
      8'hC0 : mul_by_11 = 8'h01;
      8'hC1 : mul_by_11 = 8'h0A;
      8'hC2 : mul_by_11 = 8'h17;
      8'hC3 : mul_by_11 = 8'h1C;
      8'hC4 : mul_by_11 = 8'h2D;
      8'hC5 : mul_by_11 = 8'h26;
      8'hC6 : mul_by_11 = 8'h3B;
      8'hC7 : mul_by_11 = 8'h30;
      8'hC8 : mul_by_11 = 8'h59;
      8'hC9 : mul_by_11 = 8'h52;
      8'hCA : mul_by_11 = 8'h4F;
      8'hCB : mul_by_11 = 8'h44;
      8'hCC : mul_by_11 = 8'h75;
      8'hCD : mul_by_11 = 8'h7E;
      8'hCE : mul_by_11 = 8'h63;
      8'hCF : mul_by_11 = 8'h68;
      8'hD0 : mul_by_11 = 8'hB1;
      8'hD1 : mul_by_11 = 8'hBA;
      8'hD2 : mul_by_11 = 8'hA7;
      8'hD3 : mul_by_11 = 8'hAC;
      8'hD4 : mul_by_11 = 8'h9D;
      8'hD5 : mul_by_11 = 8'h96;
      8'hD6 : mul_by_11 = 8'h8B;
      8'hD7 : mul_by_11 = 8'h80;
      8'hD8 : mul_by_11 = 8'hE9;
      8'hD9 : mul_by_11 = 8'hE2;
      8'hDA : mul_by_11 = 8'hFF;
      8'hDB : mul_by_11 = 8'hF4;
      8'hDC : mul_by_11 = 8'hC5;
      8'hDD : mul_by_11 = 8'hCE;
      8'hDE : mul_by_11 = 8'hD3;
      8'hDF : mul_by_11 = 8'hD8;
      8'hE0 : mul_by_11 = 8'h7A;
      8'hE1 : mul_by_11 = 8'h71;
      8'hE2 : mul_by_11 = 8'h6C;
      8'hE3 : mul_by_11 = 8'h67;
      8'hE4 : mul_by_11 = 8'h56;
      8'hE5 : mul_by_11 = 8'h5D;
      8'hE6 : mul_by_11 = 8'h40;
      8'hE7 : mul_by_11 = 8'h4B;
      8'hE8 : mul_by_11 = 8'h22;
      8'hE9 : mul_by_11 = 8'h29;
      8'hEA : mul_by_11 = 8'h34;
      8'hEB : mul_by_11 = 8'h3F;
      8'hEC : mul_by_11 = 8'h0E;
      8'hED : mul_by_11 = 8'h05;
      8'hEE : mul_by_11 = 8'h18;
      8'hEF : mul_by_11 = 8'h13;
      8'hF0 : mul_by_11 = 8'hCA;
      8'hF1 : mul_by_11 = 8'hC1;
      8'hF2 : mul_by_11 = 8'hDC;
      8'hF3 : mul_by_11 = 8'hD7;
      8'hF4 : mul_by_11 = 8'hE6;
      8'hF5 : mul_by_11 = 8'hED;
      8'hF6 : mul_by_11 = 8'hF0;
      8'hF7 : mul_by_11 = 8'hFB;
      8'hF8 : mul_by_11 = 8'h92;
      8'hF9 : mul_by_11 = 8'h99;
      8'hFA : mul_by_11 = 8'h84;
      8'hFB : mul_by_11 = 8'h8F;
      8'hFC : mul_by_11 = 8'hBE;
      8'hFD : mul_by_11 = 8'hB5;
      8'hFE : mul_by_11 = 8'hA8;
      8'hFF : mul_by_11 = 8'hA3;
      default : mul_by_11 = 0;
    endcase
  endfunction
endmodule