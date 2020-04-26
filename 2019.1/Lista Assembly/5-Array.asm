	.data
array: 	.byte 10, 5, 7, 9
	
tamanho: .word 4

.globl main
.text 

main:
	la $s0, array
	lw $s1, tamanho
	
	subi $t0, $s1, 1

loop:
	bltz $t0, end
	add $a1, $t0, $s0
	lb $t1, 0($a1)
	add $a0, $a0, $t1
	subi $t0, $t0, 1
	j loop
	
end:
	li $v0, 1
	move $a1, $a0
	syscall
