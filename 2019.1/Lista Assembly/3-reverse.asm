	.data
input:	.asciiz "TeSt:E\0"
error: .asciiz "\nCaractere que não é uma letra no Input "
output:	.space	256
nextLine: .asciiz "\n"

	.text
	.globl main
main:			
	la	$a0, input		# Load no input
	li	$a1, 256		# só 256 bytes são permitidos
	
	li	$v0, 4			# Print da String para verificar
	la	$a0, input
	syscall
	
	jal	strlen			# Conta os caracteres da string
	
	add	$t1, $zero, $v0		# Copia alguns parametros para nossa funçao reverter
	add	$t2, $zero, $a0		# salvando a string inputada para $t2, já que ela é
	add	$a0, $zero, $v0		# detonada pelo syscall.
	
	
reverter:
	li	$t0, 0			# Colocar t0 pra zero pra garantir
	li	$t3, 0			# O mesmo para t3
	
	reverterLoop:
		add	$t3, $t2, $t0		# $t2 é o endereço base para o nosso array 'input', add index pro loop
		lb	$t4, 0($t3)		# Carrega um byte por vez de acordo com o contador
		beqz	$t4, exit		# Achamos o fim da string
		blt	$t4, 97, toLower	# Verifica se o index do caractere é menor que "a" podendo ser maiuscula
		bgt 	$t4, 122, otherChar	# Verifica se o index do caractere é maior que "z" sendo outro Char além de letra
		addi	$t4, $t4, -32		# Subtrai 32 do caractere para transformar ele em Maiusculo
		sb	$t4, output($t1)	# Sobscreve o byte na memoria	
		subi	$t1, $t1, 1		# Subtract our overall string length by 1 (j--)
		addi	$t0, $t0, 1		# Advance our counter (i++)
		j	reverterLoop		# Loop until we reach our condition

toLower:
	blt	$t4, 65, otherChar	# Outro caractere além de letra
	bgt	$t4, 90, otherChar	# Caractere está entre o minusculo e o maiusculo, mas não é letra
	addi	$t4, $t4, +32		# Transforma o caractere em Minusculo
	sb	$t4, output($t1)	# Overwrite this byte address in memory	
	subi	$t1, $t1, 1		# Subtract our overall string length by 1 (j--)
	addi	$t0, $t0, 1		# Advance our counter (i++)
	j	reverterLoop	
	
otherChar:
	addi $v1, $zero, 1
	li	$v0, 4			
	la	$a0, error		# Printa que achou um char que não é letra
	syscall
			
exit:
	li	$v0, 4			
	la	$a0, nextLine		# Pula linha
	syscall
	
	li	$v0, 4			# Printa
	la	$a0, output		# a string ao contrário.
	syscall
		
	li	$v0, 10			# exit()
	syscall


strlen:
	li	$t0, 0
	li	$t2, 0
	
	strlen_loop:
		add	$t2, $a0, $t0
		lb	$t1, 0($t2)
		
		beqz	$t1, strlen_exit
		addiu	$t0, $t0, 1
		j	strlen_loop
		
	strlen_exit:
		subi	$t0, $t0, 1
		add	$v0, $zero, $t0
		add	$t0, $zero, $zero
		jr	$ra