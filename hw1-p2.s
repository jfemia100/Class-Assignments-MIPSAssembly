# Description:
# This is an example of a for loop. Asks user for a value called size. Then the 
# loop adds the initialized value to the size and then prints the total. Then it
# adds one to initialized value and starts the loop all over again. Loop keeps
# going until the initialized value is no longer less than the size. Then it exits.

# Registers Used:
# Size = $s1
# Initialized Value (j) = $s2

.data

size: .asciiz "Please enter the value of the size: "
jequal: .asciiz "If j equals "
tequal: .asciiz ", then the total equals "
nextline: .asciiz "\n"

.text

main:

# prompts user for size

	la $a0, size		#gets address of size
	li $v0, 4		    #prints string
	syscall

#read size

	li $v0, 5		    #saves input
	syscall
	move $s1, $v0		#moves input to $s1

#loop
	
	li $s2, 1		#initialize a value of 1

	while:			# start of the loop

	slt $t0, $s2, $s1	        #checks to see if initialized value is less than size
	bne $t0, $zero, print	    #if value is less than size, program jumps to print
	j exit			              #if value is not less than size, program exits loop

	print:

	add $t1, $s1, $s2	      #adds $s1 and $s2 and stores it in $t1
	
	la $a0, jequal		#
	li $v0, 4		      #gets address, and prints jequal string
	syscall			      #

	move $a0, $s2		  #
	li $v0, 1     		#moves $s2 into register, then prints int
	syscall			      #
	
	la $a0, tequal		#
	li $v0, 4		      #gets address, and prints tequal string
	syscall			      #

	move $a0, $t1		  #
	li $v0, 1     		#moves $t1 into register, then prints int
	syscall			      #

	la $a0, nextline	  #	
	li $v0, 4		        #prints a new line
	syscall			        #

	add $s2, $s2, 1		  #adds 1 to $s1

	j while			  #jumps back to while and starts loop all over again

#exit
	exit:
	li $v0, 10		# This exits the program
	syscall			  #
