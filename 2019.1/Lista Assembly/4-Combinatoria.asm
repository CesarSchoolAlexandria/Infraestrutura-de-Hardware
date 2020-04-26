		.data
n: .word 0
s: .word 0

COMB: .word 0

.globl main
.text

main:
	lw $s0, n 		# Carregando o "n"
	lw $s1, s		# Carregando o "s"
	
	# No meu entendimento da questão o caso 4 tem maior importância então deve se começar verificando por ele
	beqz $s0, igualZero	# se "n" for igual a zero
	beqz $s1, igualZero 	# se "s" for igual a zero
	
	beq  $s0, $s1, igual	# se "n" e "s" forem iguais

	bltz $s0, menorZero	# se "n" for menor que 0
	bltz $s1, menorZero	# se "s" for menor que 0
			
	blt $s0, $s1, sMaior 	# se "s" for maior que "n"



	
	move $a0, $s0		# copia o valor do "n" pra $a0
	jal fatorial		# vai pra função fatorial
	move $s2, $v0		# salva o resultado do fatorial no registrador $s2
		
	move $a0, $s1		# copia o valor do "s" para $a0
	jal fatorial		# vai para a função fatorial
	move $s3, $v0		# salva o resultado do fatorial no registrador $s3
	
	sub $a0, $s0, $s1	# faz "n - s" e passa o valor para $a0
	jal fatorial		# vai para a função fatorial
	move $s4, $v0		# salva o resultado do fatorial no registrador
	
	mul $t0, $s3, $s4	# multiplica o $s4 pelo $s3 para preparar o divisor
	div $t1, $s2, $t0	# realiza a divisão e salva o valor em $s6
 	
 	sw $t1, COMB
 	
 	j end
sMaior:
	addi $v1, $zero, 1	# Salva 1 no registrador $v1
	j end
menorZero:
	addi $v1, $zero, 2	# Salva 2 no registrador $v1
	j end
igual:
	addi $v1, $zero, 3	# Salva 3 no registrador $v1
	j end
igualZero:
	addi $v1, $zero, 4	# Salva 4 no registrador $v1
	j end			# Meu entendimento da questão é que ele vai verificar todas as possibilidades até o igualZero
				# e ele vai gravar na determinada ordem de relevancia: 4, 3, 2, 1

fatorial:
	addi $sp, $sp, -8 
	sw   $s0, 4($sp)
    	sw   $ra, 0($sp)
    	bne  $a0, 0, else
    	addi $v0, $zero, 1    # return 1
    	j fat_return

else:
	move $s0, $a0
    	addi $a0, $a0, -1 # x -= 1
    	jal  fatorial
    	# Agora temos Fatorial de (x-1) em $v0
    	multu   $s0, $v0 # return x*Fact(x-1)
    	mflo    $v0
    	
fat_return:
    	lw      $s0, 4($sp)
    	lw      $ra, 0($sp)
    	addi    $sp, $sp, 8
   	jr      $ra
	
end:
	