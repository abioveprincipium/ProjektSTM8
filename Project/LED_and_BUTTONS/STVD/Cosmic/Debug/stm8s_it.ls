   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.2 - 04 Jun 2024
   3                     ; Generator (Limited) V4.6.4 - 15 Jan 2025
   4                     ; Optimizer V4.6.4 - 15 Jan 2025
  51                     ; 55 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  51                     ; 56 {
  52                     .text:	section	.text,new
  53  0000               f_NonHandledInterrupt:
  57                     ; 60 }
  60  0000 80            	iret	
  82                     ; 68 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  82                     ; 69 {
  83                     .text:	section	.text,new
  84  0000               f_TRAP_IRQHandler:
  88                     ; 73 }
  91  0000 80            	iret	
 113                     ; 80 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 113                     ; 81 
 113                     ; 82 {
 114                     .text:	section	.text,new
 115  0000               f_TLI_IRQHandler:
 119                     ; 86 }
 122  0000 80            	iret	
 144                     ; 93 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 144                     ; 94 {
 145                     .text:	section	.text,new
 146  0000               f_AWU_IRQHandler:
 150                     ; 98 }
 153  0000 80            	iret	
 175                     ; 105 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 175                     ; 106 {
 176                     .text:	section	.text,new
 177  0000               f_CLK_IRQHandler:
 181                     ; 110 }
 184  0000 80            	iret	
 207                     ; 117 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 207                     ; 118 {
 208                     .text:	section	.text,new
 209  0000               f_EXTI_PORTA_IRQHandler:
 213                     ; 122 }
 216  0000 80            	iret	
 239                     ; 129 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 239                     ; 130 {
 240                     .text:	section	.text,new
 241  0000               f_EXTI_PORTB_IRQHandler:
 245                     ; 134 }
 248  0000 80            	iret	
 271                     ; 141 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 271                     ; 142 {
 272                     .text:	section	.text,new
 273  0000               f_EXTI_PORTC_IRQHandler:
 277                     ; 146 }
 280  0000 80            	iret	
 303                     ; 153 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 303                     ; 154 {
 304                     .text:	section	.text,new
 305  0000               f_EXTI_PORTD_IRQHandler:
 309                     ; 158 }
 312  0000 80            	iret	
 335                     ; 165 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 335                     ; 166 {
 336                     .text:	section	.text,new
 337  0000               f_EXTI_PORTE_IRQHandler:
 341                     ; 170 }
 344  0000 80            	iret	
 366                     ; 192  INTERRUPT_HANDLER(CAN_RX_IRQHandler, 8)
 366                     ; 193  {
 367                     .text:	section	.text,new
 368  0000               f_CAN_RX_IRQHandler:
 372                     ; 197  }
 375  0000 80            	iret	
 397                     ; 204  INTERRUPT_HANDLER(CAN_TX_IRQHandler, 9)
 397                     ; 205  {
 398                     .text:	section	.text,new
 399  0000               f_CAN_TX_IRQHandler:
 403                     ; 209  }
 406  0000 80            	iret	
 428                     ; 217 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 428                     ; 218 {
 429                     .text:	section	.text,new
 430  0000               f_SPI_IRQHandler:
 434                     ; 222 }
 437  0000 80            	iret	
 460                     ; 229 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 460                     ; 230 {
 461                     .text:	section	.text,new
 462  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 466                     ; 234 }
 469  0000 80            	iret	
 492                     ; 241 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 492                     ; 242 {
 493                     .text:	section	.text,new
 494  0000               f_TIM1_CAP_COM_IRQHandler:
 498                     ; 246 }
 501  0000 80            	iret	
 526                     ; 280  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 526                     ; 281  {
 527                     .text:	section	.text,new
 528  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 530  0000 8a            	push	cc
 531  0001 84            	pop	a
 532  0002 a4bf          	and	a,#191
 533  0004 88            	push	a
 534  0005 86            	pop	cc
 535  0006 3b0002        	push	c_x+2
 536  0009 be00          	ldw	x,c_x
 537  000b 89            	pushw	x
 538  000c 3b0002        	push	c_y+2
 539  000f be00          	ldw	x,c_y
 540  0011 89            	pushw	x
 543                     ; 282 	 TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
 545  0012 a601          	ld	a,#1
 546  0014 cd0000        	call	_TIM2_ClearITPendingBit
 548                     ; 283 	 GPIO_WriteLow(GPIOC,GPIO_PIN_5);
 550  0017 4b20          	push	#32
 551  0019 ae500a        	ldw	x,#20490
 552  001c cd0000        	call	_GPIO_WriteLow
 554  001f 84            	pop	a
 555                     ; 287  }
 558  0020 85            	popw	x
 559  0021 bf00          	ldw	c_y,x
 560  0023 320002        	pop	c_y+2
 561  0026 85            	popw	x
 562  0027 bf00          	ldw	c_x,x
 563  0029 320002        	pop	c_x+2
 564  002c 80            	iret	
 589                     ; 294  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 589                     ; 295  {
 590                     .text:	section	.text,new
 591  0000               f_TIM2_CAP_COM_IRQHandler:
 593  0000 8a            	push	cc
 594  0001 84            	pop	a
 595  0002 a4bf          	and	a,#191
 596  0004 88            	push	a
 597  0005 86            	pop	cc
 598  0006 3b0002        	push	c_x+2
 599  0009 be00          	ldw	x,c_x
 600  000b 89            	pushw	x
 601  000c 3b0002        	push	c_y+2
 602  000f be00          	ldw	x,c_y
 603  0011 89            	pushw	x
 606                     ; 298 		 TIM2_ClearFlag(TIM2_FLAG_CC1);
 608  0012 ae0002        	ldw	x,#2
 609  0015 cd0000        	call	_TIM2_ClearFlag
 611                     ; 300 		 GPIO_WriteHigh(GPIOC,GPIO_PIN_5);
 613  0018 4b20          	push	#32
 614  001a ae500a        	ldw	x,#20490
 615  001d cd0000        	call	_GPIO_WriteHigh
 617  0020 84            	pop	a
 618                     ; 305  }
 621  0021 85            	popw	x
 622  0022 bf00          	ldw	c_y,x
 623  0024 320002        	pop	c_y+2
 624  0027 85            	popw	x
 625  0028 bf00          	ldw	c_x,x
 626  002a 320002        	pop	c_x+2
 627  002d 80            	iret	
 650                     ; 315  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 650                     ; 316  {
 651                     .text:	section	.text,new
 652  0000               f_TIM3_UPD_OVF_BRK_IRQHandler:
 656                     ; 320  }
 659  0000 80            	iret	
 682                     ; 327  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 682                     ; 328  {
 683                     .text:	section	.text,new
 684  0000               f_TIM3_CAP_COM_IRQHandler:
 688                     ; 332  }
 691  0000 80            	iret	
 714                     ; 342  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 714                     ; 343  {
 715                     .text:	section	.text,new
 716  0000               f_UART1_TX_IRQHandler:
 720                     ; 347  }
 723  0000 80            	iret	
 746                     ; 354  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 746                     ; 355  {
 747                     .text:	section	.text,new
 748  0000               f_UART1_RX_IRQHandler:
 752                     ; 359  }
 755  0000 80            	iret	
 777                     ; 393 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 777                     ; 394 {
 778                     .text:	section	.text,new
 779  0000               f_I2C_IRQHandler:
 783                     ; 398 }
 786  0000 80            	iret	
 809                     ; 432  INTERRUPT_HANDLER(UART3_TX_IRQHandler, 20)
 809                     ; 433  {
 810                     .text:	section	.text,new
 811  0000               f_UART3_TX_IRQHandler:
 815                     ; 437  }
 818  0000 80            	iret	
 841                     ; 444  INTERRUPT_HANDLER(UART3_RX_IRQHandler, 21)
 841                     ; 445  {
 842                     .text:	section	.text,new
 843  0000               f_UART3_RX_IRQHandler:
 847                     ; 449  }
 850  0000 80            	iret	
 872                     ; 458  INTERRUPT_HANDLER(ADC2_IRQHandler, 22)
 872                     ; 459  {
 873                     .text:	section	.text,new
 874  0000               f_ADC2_IRQHandler:
 878                     ; 463  }
 881  0000 80            	iret	
 904                     ; 502  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 904                     ; 503  {
 905                     .text:	section	.text,new
 906  0000               f_TIM4_UPD_OVF_IRQHandler:
 910                     ; 546  }
 913  0000 80            	iret	
 936                     ; 554 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 936                     ; 555 {
 937                     .text:	section	.text,new
 938  0000               f_EEPROM_EEC_IRQHandler:
 942                     ; 559 }
 945  0000 80            	iret	
 980                     	switch	.bss
 981  0000               _key_count:
 982  0000 0000          	ds.b	2
 983                     	xdef	_key_count
 984  0002               _key_mode:
 985  0002 00            	ds.b	1
 986                     	xdef	_key_mode
 987  0003               _key_flag:
 988  0003 00            	ds.b	1
 989                     	xdef	_key_flag
 990                     	xdef	f_EEPROM_EEC_IRQHandler
 991                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 992                     	xdef	f_ADC2_IRQHandler
 993                     	xdef	f_UART3_TX_IRQHandler
 994                     	xdef	f_UART3_RX_IRQHandler
 995                     	xdef	f_I2C_IRQHandler
 996                     	xdef	f_UART1_RX_IRQHandler
 997                     	xdef	f_UART1_TX_IRQHandler
 998                     	xdef	f_TIM3_CAP_COM_IRQHandler
 999                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1000                     	xdef	f_TIM2_CAP_COM_IRQHandler
1001                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1002                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1003                     	xdef	f_TIM1_CAP_COM_IRQHandler
1004                     	xdef	f_SPI_IRQHandler
1005                     	xdef	f_CAN_TX_IRQHandler
1006                     	xdef	f_CAN_RX_IRQHandler
1007                     	xdef	f_EXTI_PORTE_IRQHandler
1008                     	xdef	f_EXTI_PORTD_IRQHandler
1009                     	xdef	f_EXTI_PORTC_IRQHandler
1010                     	xdef	f_EXTI_PORTB_IRQHandler
1011                     	xdef	f_EXTI_PORTA_IRQHandler
1012                     	xdef	f_CLK_IRQHandler
1013                     	xdef	f_AWU_IRQHandler
1014                     	xdef	f_TLI_IRQHandler
1015                     	xdef	f_TRAP_IRQHandler
1016                     	xdef	f_NonHandledInterrupt
1017                     	xref	_TIM2_ClearITPendingBit
1018                     	xref	_TIM2_ClearFlag
1019                     	xref	_GPIO_WriteLow
1020                     	xref	_GPIO_WriteHigh
1021                     	xref.b	c_x
1022                     	xref.b	c_y
1042                     	end
