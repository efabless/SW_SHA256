/*
	Copyright 2023 secworks

	Author: Joachim Strombergson ()

	This file is auto-generated by wrapper_gen.py on 2023-11-28

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


#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const unsigned int
#define   __W     volatile       unsigned int
#define   __RW    volatile       unsigned int
#endif

#define SW_SHA256_STATUS_REG_READY_REG		7
#define SW_SHA256_STATUS_REG_READY_REG_LEN	1
#define SW_SHA256_STATUS_REG_DIGEST_VALID_REG		8
#define SW_SHA256_STATUS_REG_DIGEST_VALID_REG_LEN	1
#define SW_SHA256_CTRL_REG_INIT_REG		0
#define SW_SHA256_CTRL_REG_INIT_REG_LEN	1
#define SW_SHA256_CTRL_REG_NEXT_REG		1
#define SW_SHA256_CTRL_REG_NEXT_REG_LEN	1
#define SW_SHA256_CTRL_REG_MODE_REG		2
#define SW_SHA256_CTRL_REG_MODE_REG_LEN	1
#define SW_SHA256_VALID_FLAG	0x1
#define SW_SHA256_READY_FLAG	0x2

typedef struct _SW_SHA256_TYPE_ {
	__R 	STATUS;
	__RW	CTRL;
	__RW	BLOCK0;
	__RW	BLOCK1;
	__RW	BLOCK2;
	__RW	BLOCK3;
	__RW	BLOCK4;
	__RW	BLOCK5;
	__RW	BLOCK6;
	__RW	BLOCK7;
	__RW	BLOCK8;
	__RW	BLOCK9;
	__RW	BLOCK10;
	__RW	BLOCK11;
	__RW	BLOCK12;
	__RW	BLOCK13;
	__RW	BLOCK14;
	__RW	BLOCK15;
	__R 	DIGEST0;
	__R 	DIGEST1;
	__R 	DIGEST2;
	__R 	DIGEST3;
	__R 	DIGEST4;
	__R 	DIGEST5;
	__R 	DIGEST6;
	__R 	DIGEST7;
	__R 	reserved[934];
	__W 	icr;
	__R 	ris;
	__RW	im;
	__R 	mis;
} SW_SHA256_TYPE;
