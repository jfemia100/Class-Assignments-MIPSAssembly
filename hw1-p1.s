# Description:
# The program asks you to input two integers and then prints them in
# increasing order. Then it multiplies the second integer by 16 and 
# subtracts it from the first integer. Then depending on where the 
# answer is positive or negative, the program prints the string that
# correlates to the answer. The program is in a while loop so it keeps
# continuing until the user enters 999 as the first integer.

# Registers Used:
# 1st Integer = $s1
# 2nd Integer = $s2


.data		

int1: .asciiz "Please enter an integer between 0 and 20: "
int2: .asciiz "Please enter an integer between -10 and 15: "
order: .asciiz "Your numbers in increasing order are: "
presult: .asciiz "The result is a positive number equal to "
nresult: .asciiz "The result is a negative number equal to "
comma: .asciiz ", "
newline: .asciiz "\n"

.text

main:

	While:			# Start of the while loop

#prompt user for 1st int

	la $a0, int1		#gets address of int1
	li $v0, 4		    #prints string
	syscall

#read int1

	li $v0, 5		        #saves input
	syscall
	move $s1, $v0		    #moves input to $s1
	
	beq $s1, 999, exit	#if user inputs 999 program exits while loop

#prompt user for 2nd int

	la $a0, int2		#gets address of int2
	li $v0, 4		    #prints string
	syscall

#read int2

	li $v0, 5		    #saves input
	syscall
	move $s2, $v0		#moves input to $s2

#numbers in increasing order

	la $a0, order		#gets address of order
	li $v0, 4 		  #prints string
	syscall
	
	slt $t0, $s1, $s2	      #checks if $s1 is less than $s2
	bne $t0, $zero, print	  # if $s1 is less than $s2 progam jumbs to print
	
	move $a0, $s2		#
	li $v0, 1   		#
	syscall			    #
	la $a0, comma		# This section prints $s2 then $s1 if 
	li $v0, 4 		  # $s2 is less than $s1
	syscall			    #
	move $a0, $s1		#
	li $v0, 1   		#
  syscall		      #

	j Break			# jumps to break

	print: 
	move $a0, $s1		  #
	li $v0, 1     		#
	syscall			      #
	la $a0, comma		  # This section prints $s1 then $s2 if
	li $v0, 4 		    # $s1 is less than $s2
	syscall			      #
	move $a0, $s2		  #
	li $v0, 1     		#
	syscall			      #

	Break:
	la $a0, newline		#
	li $v0, 4 		    # This goes to the new line
	syscall			      #

#computations (int1 - 16*int2)

	sll $t0, $s2, 4		  # multiplies $s2 by 16 and stores it in $t0
	sub $s0, $s1, $t0	  # subtracts $t0 from $s1

	slt $t0, $s0, $zero		      #checks to see if answer is less than 0
	bne $t0, $zero, negative	  #if answer is less than 0 jump to negative

	la $a0, presult		#
	li $v0, 4 	    	# Prints presult string if answer is greater
	syscall			      # then 0
	move $a0, $s0		  # 
	li $v0, 1		      # Then prints the positive number
	syscall			      #
	
	j Break1		# jumps to break1

	negative:
	la $a0, nresult		#
	li $v0, 4 		    # Prints nresult string if answer is less
	syscall			      # then 0
	move $a0, $s0		  #
	li $v0, 1		      # Then prints the negative number
	syscall			      #

	Break1:
	la $a0, newline		#	
	li $v0, 4 		    # This goes to the new line
	syscall			      #

	j While			# This jumps back to While to start the
				      # program all over again

#exit
	exit:
	li $v0, 10		# This exits the program
	syscall			  #
