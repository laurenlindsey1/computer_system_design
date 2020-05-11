	.eqv E,250 
	.eqv Q,500 
	.eqv QQ,700 
	.eqv H,1000 
	.data
Notes:   
	.word   72,77,72,65,72,77,72,1 
	.word   72,77,72,77,81,1,79,77,76,75,74 
	.word   72,77,72,65,72,77,72,1 
	.word   77,74,72,70,69,67,65,0 
Dur:	.word   Q,Q,Q,Q,Q,Q,H,Q
	.word   Q,Q,Q,Q,QQ,Q,Q,E,E,E,E
	.word   Q,Q,Q,Q,Q,Q,H,Q
	.word   QQ,Q,Q,Q,Q,Q,Q,0
 .text
 main:
   	li $a2, 69		# set instrument to one of my choice
 	li $a3, 100		# set volume to one of my choice
 	la $t1, Notes		# load address for Notes
 	lw $t2, 0($t1)		# first value in Notes
 	la $t3, Dur 		# load address for Dur
 	lw $t4, 0($t3)		# first value in Dur
 	jal function1		# jump to function1, return here when done
 	li $v0, 10		# system call for exit
 	syscall
function1:
	addi $sp, $sp, -4	# make space on stack pointer
	sw $ra, 0($sp)		# hold return address on stack
	j loop			# jump to loop
 
 loop:
 	move $a0, $t2		# set note to a0 for syscall
 	move $a1, $t4		# set duration to a1 for syscall
 	li   $v0, 31 		# code for midi out
	syscall
	jal function2		#jump to function2 and return here when done
	addi $t1, $t1, 4 	# increment address of the current note
 	lw $t2, 0($t1) 		# load next note	
 	addi $t3, $t3, 4 	# increment address of the current dur
 	lw $t4, 0($t3) 		# load next dur
	bne $t2, 0, loop	# done when value == 35
	lw $ra, 0($sp)		# grab $ra from stack pointer
	addi $sp, $sp, 4	# restore stack
	jr $ra

function2:
	li   $v0, 32 		# code for sleep
	la   $a0, 400 		# specify length of sleep
	syscall
	jr $ra			# return


### registers I used, and what for
# $t1: address of Notes
# $t2: iterates through Notes, holds one Note at a time
# $t3: address of Dur
# $t4: iterates through Dur, holds one Dur at a time
# $sp: used to store return address so program can properly terminate
# $a0: function argument, for syscall 32 indicates length of sleep, for syscall 31 indicates the note
# $a1: function argument, for syscall 31 indicates the duration of the note
