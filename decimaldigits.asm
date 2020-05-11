.data
theString:
	.space 101
Prompt:.asciiz "Please enter a string: "
Result: .asciiz "The number of decimal digits: "

.text
main:
	li   $v0, 4 		#load to print user prompt 
	la   $a0, Prompt
	syscall

 	li   $v0, 8		#get user entered number
 	la   $a0, theString
 	li   $a1, 100
 	syscall
 	
 	la   $t0, 0($a0) 	# store a shifting version of user input into t0
 	lb   $t1, 0($t0)	# set t1 to our first character in the string
 	li   $t2, 0       	# set t2 to our running count of decimal values

checkdigit: 
	blt   $t1, 48, loop 	# branch if ascii value is less than the range from 0-9
	bgt   $t1, 58, loop 	# branch if ascii value is greater than the range from 0-9
 	addi  $t2, $t2, 1	# if no branch, it is 0-9, add 1 to our counter
 	j     loop 		# increment the address


loop: 
	add   $t1, $0, $0 	# set t1 back to 0
	addi  $t0, $t0, 1 	# increment t0 by a letter
	lbu   $t1, 0($t0) 	# set new letter to t1
	beq   $t1, $0, print 	# if its empty, then we are done
 	j     checkdigit 	# jump to our function that checks for digit value

print:
	li   $v0, 4		#load to print result string
 	la   $a0, Result
 	syscall

	move   $a0,$t2		#load to print the number of decimal values
	li     $v0, 1
	syscall
	
	li   $v0, 10          	# system call for exit
	syscall              	# we are out of here.
	
#### What I used registers for:
# $t0: store the address of user input
# $t1: holds 1 character of user input
# $t2: running count of number of decimal digits
