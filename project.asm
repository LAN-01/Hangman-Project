#CS2640
#This code is to implement a portion of the Hangman game

.data
msg1: .asciiz "\nEnter a character: "
msg2: .asciiz "\nYour character appears this many times in the word: "
key: .asciiz "test"
userInput: .space 2

.text
main:
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
	beq $t2,$zero,exit #if index = zero(non element), jump to exit
	addi $s2,$s2,1	#else, continue itteration
	j L1
	L2:
	addi $t7,$t7,1	#records that character appears in the word
	addi $s2,$s2,1 
	j L1
	
	





exit:
la $a0, msg2 #character appearance message
li $v0, 4
syscall
la $a0,($t7)
li $v0,1
syscall

li $v0, 10

