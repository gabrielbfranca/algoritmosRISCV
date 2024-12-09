.data
vetor: .word 9,2,5,1,8,2,4,3,6,7
newl: .string "\n"
tab: .string "\t"
.text
main: 
	la a4, vetor 
	
	#jal clear1
	#li a1, 4 # position to swap
	#jal swap
	
	li a1, 10
	jal sort
	
	li a1, 10 # size
	jal printVetor
	
exit:	li a7,10
	ecall
	
clear1: mv t0, zero # while
Loop1: 
	slli t1, t0, 2 #itera��o
	add t2, a0, t1 #t2 � o endere�o, instru��o executa itera��o
	sw zero, 0(t2) # execu��o
	addi t0, t0, 1 # pr�xima itera��o
	blt t0, a1, Loop1 
	ret

printVetor: mv t0, zero
print:
	slli t1,t0,2
	add t2,a4, t1
	
	lw a0, 0(t2)
	li a7, 1
	ecall
	
	addi t0,t0, 1
	blt t0,a1, print
	ret
	

swap:
	slli t1,a1,2 # posi��o			
	add t2, a4, t1
	lw t3, 0(t2)
	lw t4, 4(t2)
	
	sw t4, 0(t2)
	sw t3, 4(t2)
	ret
	
sort: mv t0, zero
sortloop:
	# i = t0 j = t5
	slli t1, t0,2
	add t2, a4, t1 # t2 ender�o do vetor com nova posi��o	
	beq t0, zero, firstJump
	# novo loop
	sub t5, t0, 1
loopSwap:
	srli t6, t5, 2
 	
	
firstJump:	
	addi t0,t0, 1
	blt t0, a1, sortloop
	ret
	
	
	


