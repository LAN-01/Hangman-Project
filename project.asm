#Christian Williams

.data

  correctarray: .byte 'l', 'h', 'o'
  spacemsg: .asciiz "_"
  word: .asciiz "hello"
  msg1: .asciiz "Enter a letter\n"


 
 .text 
 
 main:
 la $t0, word
 la $t1, correctarray
 li $s0, 2
 li $s1, 4
 li $t7, 0
 
  
 firstloop: bgt $t7, $s1, exitloop
  
  	     add $t3, $t0, $t7
             lb $t4, ($t3)
             
            li $t2, 0
             
 innerloop:  bgt $t2, $s0, endinnerloop
  	     
  	     add $t5, $t1, $t2
  	     lb $t6, ($t5)
  	     
  	     addi $t2, $t2, 1
  	     
             beq $t6, $t4, printword
  	     
  	     j innerloop
  	     

  	     
  
  printword: 
  	   
  	   move $a0, $t6
  	   li $v0, 11
  	   syscall
  	   
  	   addi $t7, $t7, 1
  	   
  	   j firstloop
  	   
  	       	       
  endinnerloop:  
  
   la $a0, spacemsg
   li $v0, 4
   syscall
   
  addi $t7, $t7, 1
  
  j firstloop
  
  exitloop:
  
  
 exit:
  li $v0, 10
  syscall