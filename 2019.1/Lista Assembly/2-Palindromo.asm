.data
input: .asciiz	"arara"
inputLen: .word	5	

.text
main:
	la	$a0, inputLen	# Carregue o tamanho da palavra em $a0
	lw	$a0, 0($a0)	# Pegue o carractere que mostra o tamanho da palavra
	la	$a1, input	# Carregue a palavra em $a1
	jal 	Palindromo	# Verificar se � um pal�ndromo
	add	$a0, $v0, $zero #
	jal	printResultado	# Print o resultado
	addi	$v0, $zero, 10  #
	syscall			# Sair


Palindromo:
	# Verificar caso base
	slti	$s0, $a0, 2
	bne	$s0, $zero, returnV

	# Garantir que a primeira e a ultima letra s�o iguais
	lb	$s0, 0($a1)
	addi	$s1, $a0, -1
	add	$s1, $s1, $a1
	lb	$s1, 0($s1)
	bne	$s0, $s1, returnF
	
	# Mudar o ponteiro, length, e realizar recurs�o
	addi	$a0, $a0, -2
	addi	$a1, $a1, 1
	j	Palindromo
	
returnF:
	addi	$v0, $zero, 0 #$v0 � a nossa flag para o print, quando � 0 o resultado � falso
	jr	$ra


returnV:
	addi	$v0, $zero, 1 #$v0 � a nossa flag para o print, quando � 1 o resultado � verdadeiro
	jr	$ra

.data
STRING_E: .asciiz	" �"
STRING_N: .asciiz	" N�o"
STRING_Palindromo: .asciiz	" um Palindromo!"

.text		
printResultado:
	add	$s4, $a0, $zero	# salve o resultado
	addi	$v0, $zero, 4 
	la	$a0, input 	# separa palavra inputada no $a0
	syscall			# print a palavra que foi inputada
	bne	$s4, $zero, printFinal
	la $a0, STRING_N  
	syscall		# print "N�o"
	j printFinal


printFinal:
	la	$a0, STRING_E
	syscall			# print "�"
	la	$a0, STRING_Palindromo
	syscall			# print "um Palindromo!"
	jr	$ra