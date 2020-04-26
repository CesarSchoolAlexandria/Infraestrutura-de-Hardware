	.data
Array: .word   14, 12, 13, 5, 9, 11, 3, 6, 7, 10, 15
	.globl main
	.text

main:
    	la  $t0, Array      # Copia o endereço do Array para $t0
    	add $t0, $t0, 44    # 4 bytes por int * 11 ints = 44 bytes
                            #adicione ou remova 4 bytes para cada int a mais ou a menos respectivamente     
                                 
loopExterno:                # determina quando terminamos de iterar o Array
    	add $t1, $0, $0     # Flag que sinaliza quando a lista foi ordenada
    	la  $a0, Array      # Coloca $a0 como o enderço base do Array
    
loopInterno:                    # Vai iterar o Array vendo se é preciso realizar uma troca
    	lw  $t2, 0($a0)         # coloca $t0 para o elemento atual do Array
    	lw  $t3, 4($a0)         # coloca $t1 para o proximo elemento do array
    	slt $t5, $t2, $t3       # $t5 = 1 if $t0 < $t1
    	beq $t5, $0, continue   # if $t5 = 1, então troque os 2
    	add $t1, $0, 1          # Se precisamos trocar, precisamos verificar a lista novamente
    	sw  $t2, 4($a0)         # coloca os maiores numeros na posição mais alta do Array (esse é o swap)
    	sw  $t3, 0($a0)         # coloca os menores numeros na posição mais baixa do Array (esse é o swap)
    
continue:
    	addi $a0, $a0, 4              # Avance o Array para começar na próxima posição
    	bne  $a0, $t0, loopInterno    # If $a0 != do fim do Array, jump de volta para o loopInterno
    	bne  $t1, $0,  loopExterno    # $t1 = 1, outra iteração é necessária, jump de volta para o loopExterno
