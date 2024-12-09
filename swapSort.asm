# https://onedrive.live.com/?authkey=%21ADZXwaqFMxgoSc4&id=6CE119DC06403022%21553148&cid=6CE119DC06403022
# https://luplab.gitlab.io/rvcodecjs/
# https://godbolt.org/
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
	slli t1, t0, 2 #iteração
	add t2, a0, t1 #t2 é o endereço, instrução executa iteração
	sw zero, 0(t2) # execução
	addi t0, t0, 1 # próxima iteração
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
	slli t1,a1,2 # posição			
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
	add t2, a4, t1 # t2 enderço do vetor com nova posição	
	beq t0, zero, firstJump
	# novo loop
	sub t5, t0, 1
loopSwap:
	srli t6, t5, 2
 	
	
firstJump:	
	addi t0,t0, 1
	blt t0, a1, sortloop
	ret
	
	
	


