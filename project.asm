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


 
 .text 
 
 main:

li $s0, 0
la $s1, correctarray  #load address of correct array


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
	j exitloop
	
addinto:
	add $t0, $s1, $s0  #index of array
        sb $t3, ($t0)   #store byte 
        
        addi $t0, $t0, 1  #update index of the array
        addi $s6, $s6, 1  #size of the array
        
       la $a0, msg3
       li $v0, 4
       syscall

 firstloop: 
 	    
 	    bgt $t8, 3, exitloop   #loop through word
  
  	    add $t5, $t4, $t8
            lb $s4, ($t5)
             
      	    li $t9,0
             
 innerloop:  beq $t9, $s6, endinnerloop     #loop through array
  	     
  	     add $t6, $s1, $t9
  	     lb $s5, ($t6)
  	     
  	     addi $t9, $t9, 1
  	     
             beq $s4, $s5, printword
  	     
  	     j innerloop
  	     

  	     
  
  printword: 
  	   
  	   move $a0, $t3
  	   li $v0, 11
  	   syscall
  	   
  	   addi $t8, $t8, 1
  	   
  	   j firstloop
  	   
  	       	       
  endinnerloop:  
  
   la $a0, spacemsg
   li $v0, 4
   syscall
   
  addi $t8, $t8, 1
  
  j firstloop
  
  exitloop:
  
  
 exit:
 
la $a0, msg2 #character appearance message
li $v0, 4
syscall
la $a0,($t7)
li $v0,1
syscall
 
 li $v0, 10
  syscall