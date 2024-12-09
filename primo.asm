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