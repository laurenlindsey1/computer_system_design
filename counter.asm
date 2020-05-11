.data
Prompt:.asciiz "Please enter an integer: "
In:.asciiz "in "
Is:.asciiz " is "
Result: .asciiz "The number of 1's "

.text
main:
	li   $v0, 4 		#load to print user prompt 
	la   $a0, Prompt
	syscall

 	li     $v0, 5		#get user entered number
 	syscall
 	move   $s1, $v0		# store an unchanged version of user input
 	move   $t3, $v0		# store a shifting version of user input into t3
 	 
 	li   $t2, 0       	# set t2 to our running count of 1's in user input
 	li   $t1, 32        	# load up loop counter
      
loop:  
	andi   $t4, $t3, 1    	# t4 = t3 & 1, should return either 0 or 1 with regard to the LSB of t3
	add    $t2, $t2, $t4	# either adds 1 or 0 depending on the t4 value, adds value to the running sum of 1's
	srl    $t3, $t3, 1	#shift our number to the right by 1
	addi   $t1, $t1, -1     # decrement loop counter
	beq    $t3, 0, print	# if the number == 0, then no more 1's so break out of loop
	bgtz   $t1, loop        # repeat if not finished yet.

print:
	li   $v0, 4		#load to print result string
 	la   $a0, Result
 	syscall

 	li   $v0, 4		# load to print in
 	la   $a0, In
 	syscall


	move   $a0, $s1		#load to print user input
	li     $v0, 1
	syscall

	li   $v0, 4		#load to print is
	la   $a0, Is
	syscall

	move   $a0,$t2		#load to print the number of 1's in user input
	li     $v0, 1
	syscall
	
	li   $v0, 10          	# system call for exit
	syscall              	# we are out of here.
	
	
### list of registers and how I used them:
# $s1: store the user input. unchanged for output printing
# $t3: stores the user input. shifted to the right in the loop to check for 1's
# $t2: running total of the number of 1's in user input. begins at 0
# $t1: loop counter. max binary length of input is 32 bits, so we start at 32
# $t4: stores whether the LSB of the shifting input ($t3) is a 1 or 0

