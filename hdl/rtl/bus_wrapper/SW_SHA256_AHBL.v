/*
	Copyright 2023 secworks

	Author: Joachim Strombergson ()

	This file is auto-generated by wrapper_gen.py on 2023-11-05

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/


`timescale			1ns/1ns
`default_nettype	none

`define		AHB_BLOCK(name, init)		always @(posedge HCLK or negedge HRESETn) if(~HRESETn) name <= init;
`define		AHB_REG(name, init, size)	`AHB_BLOCK(name, init) else if(ahbl_we & (last_HADDR[15:0]==``name``_ADDR)) name <= HWDATA[``size``-1:0];
`define		AHB_ICR(size)				`AHB_BLOCK(ICR_REG, size'b0) else if(ahbl_we & (last_HADDR[15:0]==ICR_REG_ADDR)) ICR_REG <= HWDATA[``size``-1:0]; else ICR_REG <= ``size``'d0;

module SW_SHA256_AHBL #(parameter CLKG=1) (
	input	wire 		HCLK,
	input	wire 		HRESETn,
	input	wire [31:0]	HADDR,
	input	wire 		HWRITE,
	input	wire [1:0]	HTRANS,
	input	wire 		HREADY,
	input	wire 		HSEL,
	input	wire [2:0]	HSIZE,
	input	wire [31:0]	HWDATA,
	output	wire [31:0]	HRDATA,
	output	wire 		HREADYOUT,
	output	wire 		irq
);
	localparam[15:0] STATUS_REG_ADDR = 16'h0000;
	localparam[15:0] CTRL_REG_ADDR = 16'h0004;
	localparam[15:0] BLOCK0_REG_ADDR = 16'h0008;
	localparam[15:0] BLOCK1_REG_ADDR = 16'h000c;
	localparam[15:0] BLOCK2_REG_ADDR = 16'h0010;
	localparam[15:0] BLOCK3_REG_ADDR = 16'h0014;
	localparam[15:0] BLOCK4_REG_ADDR = 16'h0018;
	localparam[15:0] BLOCK5_REG_ADDR = 16'h001c;
	localparam[15:0] BLOCK6_REG_ADDR = 16'h0020;
	localparam[15:0] BLOCK7_REG_ADDR = 16'h0024;
	localparam[15:0] BLOCK8_REG_ADDR = 16'h0028;
	localparam[15:0] BLOCK9_REG_ADDR = 16'h002c;
	localparam[15:0] BLOCK10_REG_ADDR = 16'h0030;
	localparam[15:0] BLOCK11_REG_ADDR = 16'h0034;
	localparam[15:0] BLOCK12_REG_ADDR = 16'h0038;
	localparam[15:0] BLOCK13_REG_ADDR = 16'h003c;
	localparam[15:0] BLOCK14_REG_ADDR = 16'h0040;
	localparam[15:0] BLOCK15_REG_ADDR = 16'h0044;
	localparam[15:0] DIGEST0_REG_ADDR = 16'h0048;
	localparam[15:0] DIGEST1_REG_ADDR = 16'h004c;
	localparam[15:0] DIGEST2_REG_ADDR = 16'h0050;
	localparam[15:0] DIGEST3_REG_ADDR = 16'h0054;
	localparam[15:0] DIGEST4_REG_ADDR = 16'h0058;
	localparam[15:0] DIGEST5_REG_ADDR = 16'h005c;
	localparam[15:0] DIGEST6_REG_ADDR = 16'h0060;
	localparam[15:0] DIGEST7_REG_ADDR = 16'h0064;
	localparam[15:0] ICR_REG_ADDR = 16'h0f00;
	localparam[15:0] RIS_REG_ADDR = 16'h0f04;
	localparam[15:0] IM_REG_ADDR = 16'h0f08;
	localparam[15:0] MIS_REG_ADDR = 16'h0f0c;

	reg             last_HSEL;
	reg [31:0]      last_HADDR;
	reg             last_HWRITE;
	reg [1:0]       last_HTRANS;

	always@ (posedge HCLK or negedge HRESETn) begin
		if (!HRESETn) begin
			last_HSEL       <= 0;
			last_HADDR      <= 0;
			last_HWRITE     <= 0;
			last_HTRANS     <= 0;
		end else if (HREADY) begin
			last_HSEL       <= HSEL;
			last_HADDR      <= HADDR;
			last_HWRITE     <= HWRITE;
			last_HTRANS     <= HTRANS;
		end
	end

	reg	[7:0]	CTRL_REG;
	reg	[31:0]	BLOCK0_REG;
	reg	[31:0]	BLOCK1_REG;
	reg	[31:0]	BLOCK2_REG;
	reg	[31:0]	BLOCK3_REG;
	reg	[31:0]	BLOCK4_REG;
	reg	[31:0]	BLOCK5_REG;
	reg	[31:0]	BLOCK6_REG;
	reg	[31:0]	BLOCK7_REG;
	reg	[31:0]	BLOCK8_REG;
	reg	[31:0]	BLOCK9_REG;
	reg	[31:0]	BLOCK10_REG;
	reg	[31:0]	BLOCK11_REG;
	reg	[31:0]	BLOCK12_REG;
	reg	[31:0]	BLOCK13_REG;
	reg	[31:0]	BLOCK14_REG;
	reg	[31:0]	BLOCK15_REG;
	reg	[1:0]	RIS_REG;
	reg	[1:0]	ICR_REG;
	reg	[1:0]	IM_REG;
	reg		init;
	reg		next;

	wire		ready, digest_valid;
	wire[7:0]	STATUS_REG	= {6'b0, ready, digest_valid};
	wire		mode	= CTRL_REG[2:2];
	wire[511:0] block;
	assign	block[31:0]	= BLOCK0_REG[31:0];
	assign	block[63:32]	= BLOCK1_REG[31:0];
	assign	block[95:64]	= BLOCK2_REG[31:0];
	assign	block[127:96]	= BLOCK3_REG[31:0];
	assign	block[159:128]	= BLOCK4_REG[31:0];
	assign	block[191:160]	= BLOCK5_REG[31:0];
	assign	block[223:192]	= BLOCK6_REG[31:0];
	assign	block[255:224]	= BLOCK7_REG[31:0];
	assign	block[287:256]	= BLOCK8_REG[31:0];
	assign	block[319:288]	= BLOCK9_REG[31:0];
	assign	block[351:320]	= BLOCK10_REG[31:0];
	assign	block[383:352]	= BLOCK11_REG[31:0];
	assign	block[415:384]	= BLOCK12_REG[31:0];
	assign	block[447:416]	= BLOCK13_REG[31:0];
	assign	block[479:448]	= BLOCK14_REG[31:0];
	assign	block[511:480]	= BLOCK15_REG[31:0];
	wire[255:0]	digest;
	wire[31:0]	DIGEST0_REG	= digest[31:0];
	wire[31:0]	DIGEST1_REG	= digest[63:32];
	wire[31:0]	DIGEST2_REG	= digest[95:64];
	wire[31:0]	DIGEST3_REG	= digest[127:96];
	wire[31:0]	DIGEST4_REG	= digest[159:128];
	wire[31:0]	DIGEST5_REG	= digest[191:160];
	wire[31:0]	DIGEST6_REG	= digest[223:192];
	wire[31:0]	DIGEST7_REG	= digest[255:224];
	wire		_VALID_FLAG_	= digest_valid;
	wire		_READY_FLAG_	= ready;
	wire[1:0]	MIS_REG	= RIS_REG & IM_REG;
	wire		ahbl_valid	= last_HSEL & last_HTRANS[1];
	wire		ahbl_we	= last_HWRITE & ahbl_valid;
	wire		ahbl_re	= ~last_HWRITE & ahbl_valid;
	//wire		_clk_	= HCLK;
	wire		_rst_	= ~HRESETn;

	localparam[15:0] CLKG_REG_ADDR = 16'hF000;
	wire			 gclk;
	generate
        if(CLKG == 1) begin
			reg         CLKG_REG;
            `AHB_REG(CLKG_REG, 0, 1)

			ef_gating_cell clk_gate_cell(
				   .clk(HCLK),
				   .clk_en(CLKG_REG),
				   .clk_o(gclk)
			   );
        end else
            assign gclk   = HCLK;
    endgenerate

	sha256_core inst_to_wrap (
		.clk(gclk),
		.reset_n(~_rst_),
		.init(init),
		.next(next),
		.mode(mode),
		.block(block),
		.ready(ready),
		.digest(digest),
		.digest_valid(digest_valid)
	);

	`AHB_REG(CTRL_REG, 0, 8)
	`AHB_REG(BLOCK0_REG, 0, 32)
	`AHB_REG(BLOCK1_REG, 0, 32)
	`AHB_REG(BLOCK2_REG, 0, 32)
	`AHB_REG(BLOCK3_REG, 0, 32)
	`AHB_REG(BLOCK4_REG, 0, 32)
	`AHB_REG(BLOCK5_REG, 0, 32)
	`AHB_REG(BLOCK6_REG, 0, 32)
	`AHB_REG(BLOCK7_REG, 0, 32)
	`AHB_REG(BLOCK8_REG, 0, 32)
	`AHB_REG(BLOCK9_REG, 0, 32)
	`AHB_REG(BLOCK10_REG, 0, 32)
	`AHB_REG(BLOCK11_REG, 0, 32)
	`AHB_REG(BLOCK12_REG, 0, 32)
	`AHB_REG(BLOCK13_REG, 0, 32)
	`AHB_REG(BLOCK14_REG, 0, 32)
	`AHB_REG(BLOCK15_REG, 0, 32)
	`AHB_REG(IM_REG, 0, 2)

	`AHB_ICR(2)

	always @(posedge HCLK or negedge HRESETn)
		if(~HRESETn) RIS_REG <= 32'd0;
		else begin
			if(_VALID_FLAG_) RIS_REG[0] <= 1'b1; else if(ICR_REG[0]) RIS_REG[0] <= 1'b0;
			if(_READY_FLAG_) RIS_REG[1] <= 1'b1; else if(ICR_REG[1]) RIS_REG[1] <= 1'b0;

		end

	reg valid_ctrl_wr;
	always @(posedge HCLK or negedge HRESETn) 
        if (~HRESETn) begin
            init <= 1'h0;  
            next <= 1'h0; 
			valid_ctrl_wr <= 1'b0; 
		end else if (valid_ctrl_wr) begin
            init <= CTRL_REG[0];  
            next <= CTRL_REG[1];  
			valid_ctrl_wr <= last_HADDR[15:0]==CTRL_REG_ADDR & ahbl_we;
		end else begin 
            init <= 1'h0;
            next <= 1'h0;
			valid_ctrl_wr <= last_HADDR[15:0]==CTRL_REG_ADDR & ahbl_we;
		end

	assign irq = |MIS_REG;

	assign	HRDATA = 
			(last_HADDR[15:0] == CTRL_REG_ADDR) ? CTRL_REG :
			(last_HADDR[15:0] == BLOCK0_REG_ADDR) ? BLOCK0_REG :
			(last_HADDR[15:0] == BLOCK1_REG_ADDR) ? BLOCK1_REG :
			(last_HADDR[15:0] == BLOCK2_REG_ADDR) ? BLOCK2_REG :
			(last_HADDR[15:0] == BLOCK3_REG_ADDR) ? BLOCK3_REG :
			(last_HADDR[15:0] == BLOCK4_REG_ADDR) ? BLOCK4_REG :
			(last_HADDR[15:0] == BLOCK5_REG_ADDR) ? BLOCK5_REG :
			(last_HADDR[15:0] == BLOCK6_REG_ADDR) ? BLOCK6_REG :
			(last_HADDR[15:0] == BLOCK7_REG_ADDR) ? BLOCK7_REG :
			(last_HADDR[15:0] == BLOCK8_REG_ADDR) ? BLOCK8_REG :
			(last_HADDR[15:0] == BLOCK9_REG_ADDR) ? BLOCK9_REG :
			(last_HADDR[15:0] == BLOCK10_REG_ADDR) ? BLOCK10_REG :
			(last_HADDR[15:0] == BLOCK11_REG_ADDR) ? BLOCK11_REG :
			(last_HADDR[15:0] == BLOCK12_REG_ADDR) ? BLOCK12_REG :
			(last_HADDR[15:0] == BLOCK13_REG_ADDR) ? BLOCK13_REG :
			(last_HADDR[15:0] == BLOCK14_REG_ADDR) ? BLOCK14_REG :
			(last_HADDR[15:0] == BLOCK15_REG_ADDR) ? BLOCK15_REG :
			(last_HADDR[15:0] == RIS_REG_ADDR) ? RIS_REG :
			(last_HADDR[15:0] == ICR_REG_ADDR) ? ICR_REG :
			(last_HADDR[15:0] == IM_REG_ADDR) ? IM_REG :
			(last_HADDR[15:0] == STATUS_REG_ADDR) ? STATUS_REG :
			(last_HADDR[15:0] == DIGEST0_REG_ADDR) ? DIGEST0_REG :
			(last_HADDR[15:0] == DIGEST1_REG_ADDR) ? DIGEST1_REG :
			(last_HADDR[15:0] == DIGEST2_REG_ADDR) ? DIGEST2_REG :
			(last_HADDR[15:0] == DIGEST3_REG_ADDR) ? DIGEST3_REG :
			(last_HADDR[15:0] == DIGEST4_REG_ADDR) ? DIGEST4_REG :
			(last_HADDR[15:0] == DIGEST5_REG_ADDR) ? DIGEST5_REG :
			(last_HADDR[15:0] == DIGEST6_REG_ADDR) ? DIGEST6_REG :
			(last_HADDR[15:0] == DIGEST7_REG_ADDR) ? DIGEST7_REG :
			(last_HADDR[15:0] == MIS_REG_ADDR) ? MIS_REG :
			32'hDEADBEEF;


	assign HREADYOUT = 1'b1;

endmodule
