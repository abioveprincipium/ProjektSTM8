   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.4 - 15 Jan 2025
   4                     ; Optimizer V4.6.4 - 15 Jan 2025
  22                     	switch	.data
  23  0000               _count:
  24  0000 0000          	dc.w	0
  25  0002               _tick_start:
  26  0002 0000          	dc.w	0
  27  0004               _tick_ms:
  28  0004 00000000      	dc.l	0
  29  0008               _help:
  30  0008 0000          	dc.w	0
  68                     ; 68 void delay(uint16_t tick)
  68                     ; 69 {
  70                     .text:	section	.text,new
  71  0000               _delay:
  73       00000000      OFST:	set	0
  76  0000               L72:
  77                     ; 70     while (--tick);
  79  0000 5a            	decw	x
  80  0001 26fd          	jrne	L72
  81                     ; 71 }
  84  0003 81            	ret	
 121                     ; 78 void uart_s_string(const char* str)
 121                     ; 79 {
 122                     .text:	section	.text,new
 123  0000               _uart_s_string:
 125  0000 89            	pushw	x
 126       00000000      OFST:	set	0
 129  0001 2012          	jra	L35
 130  0003               L16:
 131                     ; 82         while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 133  0003 ae0080        	ldw	x,#128
 134  0006 cd0000        	call	_UART1_GetFlagStatus
 136  0009 4d            	tnz	a
 137  000a 27f7          	jreq	L16
 138                     ; 83         UART1_SendData8(*str++);
 140  000c 1e01          	ldw	x,(OFST+1,sp)
 141  000e f6            	ld	a,(x)
 142  000f 5c            	incw	x
 143  0010 1f01          	ldw	(OFST+1,sp),x
 144  0012 cd0000        	call	_UART1_SendData8
 146  0015               L35:
 147                     ; 80     while (*str)
 149  0015 1e01          	ldw	x,(OFST+1,sp)
 150  0017 f6            	ld	a,(x)
 151  0018 26e9          	jrne	L16
 152                     ; 85 }
 155  001a 85            	popw	x
 156  001b 81            	ret	
 203                     ; 91 void main(void)
 203                     ; 92 {
 204                     .text:	section	.text,new
 205  0000               _main:
 209                     ; 98     GPIO_Init(GPIOC, GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_SLOW);
 211  0000 4bd0          	push	#208
 212  0002 4b20          	push	#32
 213  0004 ae500a        	ldw	x,#20490
 214  0007 cd0000        	call	_GPIO_Init
 216  000a 85            	popw	x
 217                     ; 99     GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_SLOW);
 219  000b 4bd0          	push	#208
 220  000d 4b40          	push	#64
 221  000f ae500a        	ldw	x,#20490
 222  0012 cd0000        	call	_GPIO_Init
 224  0015 85            	popw	x
 225                     ; 100     GPIO_Init(GPIOC, GPIO_PIN_7, GPIO_MODE_OUT_PP_HIGH_SLOW);
 227  0016 4bd0          	push	#208
 228  0018 4b80          	push	#128
 229  001a ae500a        	ldw	x,#20490
 230  001d cd0000        	call	_GPIO_Init
 232  0020 85            	popw	x
 233                     ; 102     GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_IN_FL_NO_IT);
 235  0021 4b00          	push	#0
 236  0023 4b10          	push	#16
 237  0025 ae5005        	ldw	x,#20485
 238  0028 cd0000        	call	_GPIO_Init
 240  002b 85            	popw	x
 241                     ; 103     GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_IN_FL_NO_IT);
 243  002c 4b00          	push	#0
 244  002e 4b08          	push	#8
 245  0030 ae5005        	ldw	x,#20485
 246  0033 cd0000        	call	_GPIO_Init
 248  0036 85            	popw	x
 249                     ; 104     GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_IN_FL_NO_IT);
 251  0037 4b00          	push	#0
 252  0039 4b04          	push	#4
 253  003b ae5005        	ldw	x,#20485
 254  003e cd0000        	call	_GPIO_Init
 256  0041 85            	popw	x
 257                     ; 110     UART1_Init((uint32_t)115200, 
 257                     ; 111                UART1_WORDLENGTH_8D, 
 257                     ; 112                UART1_STOPBITS_1, 
 257                     ; 113                UART1_PARITY_NO, 
 257                     ; 114                UART1_SYNCMODE_CLOCK_DISABLE, 
 257                     ; 115                UART1_MODE_TX_ENABLE);
 259  0042 4b04          	push	#4
 260  0044 4b80          	push	#128
 261  0046 4b00          	push	#0
 262  0048 4b00          	push	#0
 263  004a 4b00          	push	#0
 264  004c aec200        	ldw	x,#49664
 265  004f 89            	pushw	x
 266  0050 ae0001        	ldw	x,#1
 267  0053 89            	pushw	x
 268  0054 cd0000        	call	_UART1_Init
 270  0057 5b09          	addw	sp,#9
 271                     ; 123     TIM2_TimeBaseInit(TIM2_PRESCALER_1, 10000);
 273  0059 ae2710        	ldw	x,#10000
 274  005c 89            	pushw	x
 275  005d 4f            	clr	a
 276  005e cd0000        	call	_TIM2_TimeBaseInit
 278  0061 85            	popw	x
 279                     ; 124     TIM2_OC1Init(TIM2_OCMODE_INACTIVE, 
 279                     ; 125                  TIM2_OUTPUTSTATE_ENABLE,
 279                     ; 126                  100, 
 279                     ; 127                  TIM2_OCPOLARITY_HIGH);
 281  0062 4b00          	push	#0
 282  0064 ae0064        	ldw	x,#100
 283  0067 89            	pushw	x
 284  0068 ae2011        	ldw	x,#8209
 285  006b cd0000        	call	_TIM2_OC1Init
 287  006e 5b03          	addw	sp,#3
 288                     ; 128     TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
 290  0070 ae0101        	ldw	x,#257
 291  0073 cd0000        	call	_TIM2_ITConfig
 293                     ; 129     TIM2_ITConfig(TIM2_IT_CC1, ENABLE);
 295  0076 ae0201        	ldw	x,#513
 296  0079 cd0000        	call	_TIM2_ITConfig
 298                     ; 130     TIM2_Cmd(ENABLE);
 300  007c a601          	ld	a,#1
 301  007e cd0000        	call	_TIM2_Cmd
 303                     ; 138     TIM4_TimeBaseInit(TIM4_PRESCALER_8, 249);
 305  0081 ae03f9        	ldw	x,#1017
 306  0084 cd0000        	call	_TIM4_TimeBaseInit
 308                     ; 139     TIM4_Cmd(ENABLE);
 310  0087 a601          	ld	a,#1
 311  0089 cd0000        	call	_TIM4_Cmd
 313                     ; 140     TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 315  008c ae0101        	ldw	x,#257
 316  008f cd0000        	call	_TIM4_ITConfig
 318                     ; 146     enableInterrupts();
 321  0092 9a            	rim	
 323  0093               L57:
 324                     ; 158         GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
 326  0093 4b20          	push	#32
 327  0095 ae500a        	ldw	x,#20490
 328  0098 cd0000        	call	_GPIO_WriteHigh
 330  009b ae0009        	ldw	x,#L101
 331  009e 84            	pop	a
 332                     ; 159         uart_s_string("LED ON\n");
 334  009f cd0173        	call	LC003
 336                     ; 162         GPIO_WriteLow(GPIOC, GPIO_PIN_5);
 338  00a2 4b20          	push	#32
 339  00a4 ae500a        	ldw	x,#20490
 340  00a7 cd0000        	call	_GPIO_WriteLow
 342  00aa ae0000        	ldw	x,#L301
 343  00ad 84            	pop	a
 344                     ; 163         uart_s_string("LED OFF\n");
 346  00ae cd0173        	call	LC003
 348                     ; 171         if (key_flag)
 350  00b1 c60000        	ld	a,_key_flag
 351  00b4 271c          	jreq	L501
 352                     ; 173             GPIO_WriteLow(GPIOC, GPIO_PIN_5);
 354  00b6 4b20          	push	#32
 355  00b8 ae500a        	ldw	x,#20490
 356  00bb cd0000        	call	_GPIO_WriteLow
 358  00be ae03e8        	ldw	x,#1000
 359  00c1 84            	pop	a
 360                     ; 174             delay(1000);
 362  00c2 cd0000        	call	_delay
 364                     ; 175             GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
 366  00c5 4b20          	push	#32
 367  00c7 ae500a        	ldw	x,#20490
 368  00ca cd0000        	call	_GPIO_WriteHigh
 370  00cd 725a0000      	dec	_key_flag
 371  00d1 84            	pop	a
 372                     ; 176             key_flag--;
 374  00d2               L501:
 375                     ; 183         if (tick_ms >= (tick_start + 500))
 377  00d2 ce0002        	ldw	x,_tick_start
 378  00d5 1c01f4        	addw	x,#500
 379  00d8 cd0000        	call	c_uitolx
 381  00db ae0004        	ldw	x,#_tick_ms
 382  00de cd0000        	call	c_lcmp
 384  00e1 220b          	jrugt	L701
 385                     ; 185             tick_start += 500;
 387  00e3 ce0002        	ldw	x,_tick_start
 388  00e6 1c01f4        	addw	x,#500
 389  00e9 cf0002        	ldw	_tick_start,x
 390                     ; 186             GPIO_WriteReverse(GPIOC, GPIO_PIN_5);
 392  00ec ad7b          	call	LC002
 393  00ee               L701:
 394                     ; 194         if (TIM4_GetFlagStatus(TIM4_FLAG_UPDATE))
 396  00ee a601          	ld	a,#1
 397  00f0 cd0000        	call	_TIM4_GetFlagStatus
 399  00f3 4d            	tnz	a
 400  00f4 2715          	jreq	L111
 401                     ; 196             TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 403  00f6 a601          	ld	a,#1
 404  00f8 cd0000        	call	_TIM4_ClearFlag
 406                     ; 197             GPIO_WriteReverse(GPIOC, GPIO_PIN_5);
 408  00fb 4b20          	push	#32
 409  00fd ae500a        	ldw	x,#20490
 410  0100 cd0000        	call	_GPIO_WriteReverse
 412  0103 ce0008        	ldw	x,_help
 413  0106 5c            	incw	x
 414  0107 cf0008        	ldw	_help,x
 415  010a 84            	pop	a
 416                     ; 198             help++;
 418  010b               L111:
 419                     ; 205         if (GPIO_ReadInputPin(GPIOB, GPIO_PIN_4) == RESET)
 421  010b 4b10          	push	#16
 422  010d ae5005        	ldw	x,#20485
 423  0110 cd0000        	call	_GPIO_ReadInputPin
 425  0113 5b01          	addw	sp,#1
 426  0115 4d            	tnz	a
 427  0116 260a          	jrne	L311
 428                     ; 207             GPIO_WriteLow(GPIOC, GPIO_PIN_5);
 430  0118 4b20          	push	#32
 431  011a ae500a        	ldw	x,#20490
 432  011d cd0000        	call	_GPIO_WriteLow
 435  0120 2008          	jp	LC001
 436  0122               L311:
 437                     ; 211             GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
 439  0122 4b20          	push	#32
 440  0124 ae500a        	ldw	x,#20490
 441  0127 cd0000        	call	_GPIO_WriteHigh
 443  012a               LC001:
 444  012a 84            	pop	a
 445  012b               L121:
 446                     ; 218         while ((GPIO_ReadInputData(GPIOB) & GPIO_PIN_4) != RESET);
 448  012b ae5005        	ldw	x,#20485
 449  012e cd0000        	call	_GPIO_ReadInputData
 451  0131 a510          	bcp	a,#16
 452  0133 26f6          	jrne	L121
 453                     ; 219         count++;
 455  0135 ce0000        	ldw	x,_count
 456  0138 5c            	incw	x
 457  0139 cf0000        	ldw	_count,x
 459  013c               L721:
 460                     ; 220         while ((GPIO_ReadInputData(GPIOB) & GPIO_PIN_4) == RESET);
 462  013c ae5005        	ldw	x,#20485
 463  013f cd0000        	call	_GPIO_ReadInputData
 465  0142 a510          	bcp	a,#16
 466  0144 27f6          	jreq	L721
 467                     ; 226         GPIO_WriteLow(GPIOC, GPIO_PIN_5);
 469  0146 4b20          	push	#32
 470  0148 ae500a        	ldw	x,#20490
 471  014b cd0000        	call	_GPIO_WriteLow
 473  014e aefde8        	ldw	x,#65000
 474  0151 84            	pop	a
 475                     ; 227         delay(65000);
 477  0152 cd0000        	call	_delay
 479                     ; 228         GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
 481  0155 4b20          	push	#32
 482  0157 ae500a        	ldw	x,#20490
 483  015a cd0000        	call	_GPIO_WriteHigh
 485  015d aefde8        	ldw	x,#65000
 486  0160 84            	pop	a
 487                     ; 229         delay(65000);
 489  0161 cd0000        	call	_delay
 491                     ; 231         GPIO_WriteReverse(GPIOC, GPIO_PIN_5);
 493  0164 ad03          	call	LC002
 495  0166 cc0093        	jra	L57
 496  0169               LC002:
 497  0169 4b20          	push	#32
 498  016b ae500a        	ldw	x,#20490
 499  016e cd0000        	call	_GPIO_WriteReverse
 501  0171 84            	pop	a
 502  0172 81            	ret	
 503  0173               LC003:
 504  0173 cd0000        	call	_uart_s_string
 506                     ; 164         delay(10000);
 508  0176 ae2710        	ldw	x,#10000
 509  0179 cc0000        	jp	_delay
 544                     ; 242 void assert_failed(u8* file, u32 line)
 544                     ; 243 { 
 545                     .text:	section	.text,new
 546  0000               _assert_failed:
 550  0000               L151:
 551  0000 20fe          	jra	L151
 596                     	xdef	_main
 597                     	xdef	_uart_s_string
 598                     	xdef	_delay
 599                     	xref	_key_flag
 600                     	xdef	_help
 601                     	xdef	_tick_ms
 602                     	xdef	_tick_start
 603                     	xdef	_count
 604                     	xdef	_assert_failed
 605                     	xref	_UART1_GetFlagStatus
 606                     	xref	_UART1_SendData8
 607                     	xref	_UART1_Init
 608                     	xref	_TIM4_ClearFlag
 609                     	xref	_TIM4_GetFlagStatus
 610                     	xref	_TIM4_ITConfig
 611                     	xref	_TIM4_Cmd
 612                     	xref	_TIM4_TimeBaseInit
 613                     	xref	_TIM2_ITConfig
 614                     	xref	_TIM2_Cmd
 615                     	xref	_TIM2_OC1Init
 616                     	xref	_TIM2_TimeBaseInit
 617                     	xref	_GPIO_ReadInputPin
 618                     	xref	_GPIO_ReadInputData
 619                     	xref	_GPIO_WriteReverse
 620                     	xref	_GPIO_WriteLow
 621                     	xref	_GPIO_WriteHigh
 622                     	xref	_GPIO_Init
 623                     .const:	section	.text
 624  0000               L301:
 625  0000 4c4544204f46  	dc.b	"LED OFF",10,0
 626  0009               L101:
 627  0009 4c4544204f4e  	dc.b	"LED ON",10,0
 647                     	xref	c_lcmp
 648                     	xref	c_uitolx
 649                     	end
