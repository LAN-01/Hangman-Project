#Christian Williams --4/16/22
#homework#3.asm --This program finds the min and max of the given array
#registers used: $t0 - for the counter variable
#                $t1 & $t2 - for first element of the array
#		 $t3 - for the size of the array
#		 $t4 - To hold offset value
#		 $t5 - To hold the current element of the array
#		 $t6 - To hold physical address of the current element
#		 $t7 - The address of the array

.data
	#new array
	array: .word 9, 20, 3, 7, 9, 2, 14, 1, 11, 25
	
	#Two messages that will display before max and min
	msg1: .asciiz "The maximum is: "
	msg2: .asciiz "\nThe minimim is: "

.text 

main:
	#load address of array into register $t7
	la $t7, array
	
	#load value of 0 into register $t0 to represent the counter
	li $t0, 0
	
	#registers to represent the initial max and min
	lw $t1, ($t7)
	lw $t2, ($t7)
	
	#loads value to represent the size of the array
	li $t3, 9

	
loop:	#condition that checks to see the $t0 is bigger that $t3
	bgt $t0, $t3, exitloop
	
	 sll $t4, $t0, 2   #multiplies value of $t4 by 4
	 
	 add $t6, $t4, $t7  #$t6 = $t4 + $t7 
	 lw $t5, ($t6)      #The current element of the array
	 
	 addi $t0, $t0, 1   #updates counter variable
	 
	 #Checks to see if the current element($t5) is greater than the current max ($t1)
	 bgt $t5, $t1, max  
	 
	 #Checks to see if the current element($t5) is greater than the current min ($t2)
	 blt $t5, $t2, min
	 
	 #jumps back to the loop label
	 j loop
	 
max:     #moves value of $t5 to $t1
	 move $t1, $t5
	 j loop

min:	 #moves value of $t5 to $t2
	 move $t2, $t5
	 j loop 

exitloop:
	#print msg1 
	la $a0, msg1
	li $v0, 4
	syscall
	
	#print the maximum value
	move $a0, $t1
	li $v0, 1
	syscall
	
	#print msg2
	la $a0, msg2
	li $v0, 4
	syscall 
	
	#print minimum value 
	move $a0, $t2
	li $v0, 1
	syscall

exit:
	li $v0, 10
	syscall

	   
	
	
