#Christian Williams

.data

  correctarray: .space 20
  spacemsg: .asciiz "_"
  msg1: .asciiz "\nEnter a character: "
  msg2: .asciiz "\nYour character appears this many times in the word: "
  msg3: .asciiz "\n"
  key: .asciiz "test"
  key2: .asciiz "test"
  userInput: .space 2
  
 start: .asciiz " +---+       \n     |       \n     |       \n     |     \n------"
head: .asciiz "\n +---+       \n O   |       \n     |       \n     |     \n------"
body: .asciiz "\n +---+       \n O   |       \n |   |       \n     |     \n------"
leftArm: .asciiz "\n +---+       \n O   |      \n/|   |       \n     |     \n------"
rightArm: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n     |     \n------"
leftLeg: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n/    |     \n------"
rightLeg: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n/ \\  |     \n------"


 .text 

li $s0, 0

main:
  
 beq $s0, 7, exit
 la $s1, correctarray  #load address of correct array
 
 la $t7, 0

la $a0, msg1 #prompt user to enter a character
li $v0, 4
syscall


#read the character from user
li $v0, 8
la $a0, userInput
li $a1, 2
syscall









compareGuess:
la $s2, key	#$s2 = keyword
move $t2, $s2
la $s3, userInput	#$s3 = user's guess
move $t3,$s3
lb $t3, ($s3)
	
	L1:
	lb $t2,($s2)
	beq $t2,$t3, L2	#if characters are equal, jump to L2
	beq $t2,$zero, count #if index = zero(non element), jump to exit
	addi $s2,$s2,1	#else, continue itteration
	j L1
	L2:
	addi $t7,$t7,1	#records that character appears in the word
	addi $s2,$s2,1
	 
	j L1
 







count: 	#Stores correct letter in array

	la $t4, key2
	bgt $t7, $zero, addinto
	addi $s7, $s7, 1
	j exitloop
	
addinto:
	add $t0, $s1, $s0  #index of array
        sb $t3, ($t0)   #store byte 
        
        addi $s0, $s0, 1  #update index of the array
        addi $s6, $s6, 1  #size of the array
        beq $s6, 3, exit
        
       la $a0, msg3
       li $v0, 4
       syscall
       
       
       li $t8, 0

 firstloop: 
 	    #loop through the word
 	    bgt $t8, 3, exitloop  
  	    #new address
  	    add $t5, $t4, $t8
            lb $s4, ($t5)
             
      	    li $t9,0
             
             #loop through the correctarray
 innerloop:  beq $t9, $s6, endinnerloop     
  	     
  	     add $t6, $s1, $t9
  	     lb $s5, ($t6)
  	     addi $t9, $t9, 1
  	     #checks if letter in array is equal to 
  	     #letter in word
             beq $s4, $s5, printword    
  	     j innerloop     
  
  printword: 
  	   move $a0, $s5
  	   #print character
  	   li $v0, 11
  	   syscall
  	   addi $t8, $t8, 1
  	   
  	   j firstloop	       	       
  endinnerloop:  
  #print space
   la $a0, spacemsg
   li $v0, 4
   syscall
   
  addi $t8, $t8, 1
  
  j firstloop
  
 exitloop:
 
 
 la $a0, msg3
 li $v0, 4
 syscall
 
 
 
 
 
 printman:
 
 beq $s7, $zero, part1
 beq $s7, 1, part2
 beq $s7, 2, part3
 beq $s7, 3, part4
 beq $s7, 4, part5
 beq $s7, 5, part6
 beq $s7, 6, part7
 
part1:la $a0, start 
li $v0, 4	
syscall
j main

part2:la $a0, head
li $v0, 4	
syscall
j main 

part3:la $a0, body
li $v0, 4	
syscall
j main

part4:la $a0, leftArm
li $v0, 4	
syscall
j main

part5:la $a0, rightArm
li $v0, 4
syscall
j main

part6:la $a0, leftLeg
li $v0, 4	
syscall
j main

part7:la $a0, rightLeg
li $v0, 4	
syscall

exit:
 
la $a0, msg2 #character appearance message
li $v0, 4
syscall
la $a0,($t7)
li $v0,1
syscall
 
 li $v0, 10
 syscall