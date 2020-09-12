		.ORIG	x3000

		LD	R7, DATA_LOC
LOOP_TEST	LDR	R0, R7, #0
		BRn	OK
		LDR	R1, R7, #1		
		ADD	R7, R7, #2
		
; 测试需要移位到哪
RSHIFT		NOT 	R2, R0
		NOT	R3, R1
		LD	R4, DEC1
		AND	R5, R2, R3
NEXT_TEST	AND	R6, R5, R4
		BRz	DO
		ADD	R4, R4, R4
		BRnzp	NEXT_TEST

; 移位开始前的一些准备
DO		LD	R2, HEX4000
		AND	R5, R0, R4
		BRz	R0_RSHIFT	
 
; 对R1右移
R1_RSHIFT	ADD	R3, R1, R2
		LDR	R1, R3, #0
		AND	R5, R1, R4	;确认是否移到
		BRz	R1_RSHIFT
		BRnzp	MINUS

; 对R0右移
R0_RSHIFT	ADD	R3, R0, R2
		LDR	R0, R3, #0
		AND	R5, R0, R4	;确认是否移到
		BRz	R0_RSHIFT	

; 更相减损术
MINUS		NOT	R3, R1
		ADD	R3, R3, #1
		ADD	R3, R0, R3
		BRn	MINUS_TO_N
		BRz	LOOP_TEST
		ADD	R0, R3, #0
		BRnzp	RSHIFT
MINUS_TO_N	ADD	R3, R3, #-1
		NOT	R3, R3
		ADD	R1, R3, #0
		BRnzp	RSHIFT

OK		HALT

DATA_LOC	.FILL	xD000

LUT		.FILL	x4000
DEC1		.FILL	#1
HEX4000		.FILL	x4000
		.END