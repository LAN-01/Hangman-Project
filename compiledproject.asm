#Christian Williams, James Avila, Jana Georgievski, Luis Navarrete --5/20/22
#This program simulates the game hangman where it asks the user to guess all the letters in the word
# before all the limbs on the man are drawn out
#registers used: 
#$s0 - index of correct array
#$s1 - for the address of the word
#$s2 - array size of guessArray
#$s3 - address of user input
#$s4 - used to load byte of current letter in the word
#$s5 - used to load byte of current array letter
#$s6 - size of the correct array
#$s7 - keeps track of how many tries user has left
#$t0-$t9 have multiple functions

.data

  correctarray: .space 20
  spacemsg: .asciiz "_"
  msg1: .asciiz "\nEnter a character: "
  msg2: .asciiz "\nYour character appears this many times in the word: "
  msg3: .asciiz "\n"
  complete: "Congrats! The word is: "
  guessArray: .space 100
  userInput: .space 2
  beginningMessage: .asciiz "Welcome to Hangman! The aim of the game is to figure out the word before you run out of guesses. \nThis game was created by Christian Williams, James Avila, Jana Georgievski, Luis Navarrete.\nFirst you will choose a difficulty. Choose 1 for easy, 2 for normal, or 3 for hard.\n"
  failedMsg: .asciiz "Sorry you lose!"
  easyWord: .asciiz "books"
  normalWord: .asciiz "college"
  hardWord: .asciiz "abruptly"
  tryAgainmsg: .asciiz "\nThis letter was already guessed, try again. \n"
  
start: .asciiz " +---+       \n     |       \n     |       \n     |     \n------"
head: .asciiz "\n +---+       \n O   |       \n     |       \n     |     \n------"
body: .asciiz "\n +---+       \n O   |       \n |   |       \n     |     \n------"
leftArm: .asciiz "\n +---+       \n O   |      \n/|   |       \n     |     \n------"
rightArm: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n     |     \n------"
leftLeg: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n/    |     \n------"
rightLeg: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n/ \\  |     \n------"

num1: .word 1
num2: .word 2
num3: .word 3

.text 

main:
#print beginning message
la $a0, beginningMessage
li $v0, 4
syscall

#read number user entered
li $v0, 5
syscall


move $t0, $v0 #$t0 = user's entered number
# checks the number which the user entered
beq $t0, 1, easy
beq $t0, 2, normal
beq $t0, 3, hard

#if the user entered 1
easy:
la $s1, easyWord #load address of easy word
j beginning

#if the user entered 2
normal:
la $s1, normalWord #load address of normal word
j beginning

#if the user entered 3
hard:
la $s1, hardWord #load address of hard word
j beginning

beginning:
 
 li $t0, 0 #$t0 = 0
 
 #checks to see if user is out of turns
 beq $s7, 7, exit
 la $t1, correctarray  #load address of correct array

 la $t7, 0 #$t7 = 0
 
 #jump to the askUser label
 j askUser
 
 again: 
 	#print the try again message
 	la $a0, tryAgainmsg
 	li $v0, 4
 	syscall
 	
 
 	#prompts user to enter a character
askUser: la $a0, msg1 #prompt user to enter a character
 	 li $v0, 4
 	 syscall


  	 #read the character from user
 	  li $v0, 8
 	  la $a0, userInput
 	  li $a1, 2
	  syscall




compareGuess:

move $t2, $s1 #$t2 = address of the word
move $t4, $s1 #$t4 = address of the word
la $s3, userInput	#$s3 = user's guess
move $t3,$s3
lb $t3, ($s3) #load byte into $s3
li $t9, 0 #$t9 = 0

previousGuess: 

  	la $t5, guessArray #$t5 = previous guesses
     	
        guessLoop:
        #for loop that loops until the end of the guessArray
        bgt $t9, $s2,guessLoopEnd 
        add $t7, $t5, $t9 #address for current letter being checked 
    	lb $t6, 0($t7) #$t6 = current letter in the array
        beq $t6,$t3, again #if the current letter equals the user's guess branch to again
        addi $t9,$t9,1
        j guessLoop

    guessLoopEnd:
    add $t8, $t5, $s2 #address of guessArray current position
    sb $t3,0($t8)  #stores guess in guessArray
    addi $s2,$s2,1 #array size

	li $t7,0 #$t7 = 0
	L1:
	lb $t2,($t4)
	beq $t2,$t3, L2	#if characters are equal, jump to L2
	beq $t2,$zero, loadt #if index = zero(non element), jump to exit
	addi $t4,$t4,1	#else, continue itteration
	addi $t0, $t0,1 #amount of letters in the word
	j L1
	L2:
	addi $t7,$t7,1	#records that character appears in the word
	addi $t4,$t4,1 #continue iteration
	addi $t0, $t0, 1 
	j L1
 

	#resets all of these registers to 0 so they
	#can have multiple purposes
loadt: 	li $t8, 0
	li $t2, 0
	li $t5, 0
	li $t6, 0
	li $t9, 0


	   

count: 	#Stores correct letter in array
	
	la $a0, msg2 #character appearance message
        li $v0, 4
        syscall
        #prints how many times the character guesses appears
        la $a0,($t7) 
        li $v0,1
        syscall
        
        
	move $t2, $t0 #$t2 = $t0
	
	#checks to see if $t7 is greater than 0
	bgt $t7, $zero, addinto
	addi $s7, $s7, 1  #if not it keeps track of how many body parts have been drawn
	
	#prints new line
	la $a0, msg3 
	li $v0, 4
  	syscall
  	
  	
  	li $t8, 0 #$t8 = 0
  	li $t0, 0 #$t0 = 0
	j firstloop
	
addinto:
	add $t0, $t1, $s0  #index of array
        sb $t3, ($t0)   #store byte 
        
        addi $s0, $s0, 1  #update index of the array
        add $s6, $s6, $t7  #size of the array
        beq $s6, $t2, printWhole #if size of array equals number of letters in word
       
        #prints new line 
       la $a0, msg3
       li $v0, 4
       syscall
       
       
        li $t8, 0 #$t8 = 0
  	li $t0, 0 #$t0 = 0

 firstloop: 
 	   li $t5, 0
 	   li $t0, 0
 	    #loop through the word
 	    beq $t8, $t2, exitloop  
  	    #new address
  	    add $t5, $s1, $t8
            lb $s4, ($t5) #loads byte for current letter in the word
             
      	    li $t9,0
             
             #loop through the correctarray
 innerloop:  beq $t9, $s6, endinnerloop     
  	     
  	     add $t6, $t1, $t9
  	     lb $s5, ($t6) #loads byte for the current array letter
  	     addi $t9, $t9, 1
  	     #checks if letter in array is equal to 
  	     #letter in word
             beq $s4, $s5, printletter    
  	     j innerloop     
  
  printletter: 
  	   move $a0, $s5 #$a0 = $s5
  	   #print character
  	   li $v0, 11
  	   syscall
  	   addi $t8, $t8, 1 #iteration 
  	   
  	   j firstloop	       	       
  endinnerloop:  
  #print space
   la $a0, spacemsg
   li $v0, 4
   syscall
   
  addi $t8, $t8, 1 #iteration
  
  j firstloop
  
  
  printWhole:
  
  #print new line
  la $a0, msg3
  li $v0, 4
  syscall
  
  #prints the complete message 
  la $a0, complete
  li $v0, 4
  syscall
  
  #prints out the word
  move $a0, $s1
  li $v0, 4
  syscall
  
  #prints out a new line
  la $a0, msg3
  li $v0, 4
  syscall
  j exit
  
  
 exitloop:
 
 #prints a new line
 la $a0, msg3
 li $v0, 4
 syscall
 
 
 
 
 
 printman:
 
 #checks to see what $s7 is equal to
 beq $s7, $zero, part1
 beq $s7, 1, part2
 beq $s7, 2, part3
 beq $s7, 3, part4
 beq $s7, 4, part5
 beq $s7, 5, part6
 beq $s7, 6, part7
 
#what is printed if $s7 = 0
part1:la $a0, start 
li $v0, 4	
syscall
j beginning #jumps back to beggining

#what is printed if $s7 = 1
part2:la $a0, head
li $v0, 4	
syscall
j beginning #jumps back to beggining

#what is printed if $s7 = 2
part3:la $a0, body
li $v0, 4	
syscall
j beginning

#what is printed if $s7 = 3
part4:la $a0, leftArm
li $v0, 4	
syscall
j beginning

#what is printed if $s7 = 4
part5:la $a0, rightArm
li $v0, 4
syscall
j beginning

#what is printed if $s7 = 5
part6:la $a0, leftLeg
li $v0, 4	
syscall
j beginning

#what is printed if $s7 = 6
part7:la $a0, rightLeg
li $v0, 4	
syscall

#prints out a message telling the user they did not complete
la $a0, failedMsg
li $v0,4
syscall

exit:
 
 #exits program
 li $v0, 10
 syscall