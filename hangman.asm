.data

start: .asciiz " +---+       \n     |       \n     |       \n     |     \n------"
head: .asciiz "\n +---+       \n O   |       \n     |       \n     |     \n------"
body: .asciiz "\n +---+       \n O   |       \n |   |       \n     |     \n------"
leftArm: .asciiz "\n +---+       \n O   |      \n/|   |       \n     |     \n------"
rightArm: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n     |     \n------"
leftLeg: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n/    |     \n------"
rightLeg: .asciiz "\n +---+       \n O   |       \n/|\\  |       \n/ \\  |     \n------"

.text
main: 
la $a0, start 
li $v0, 4	
syscall

la $a0, head
li $v0, 4	
syscall

la $a0, body
li $v0, 4	
syscall

la $a0, leftArm
li $v0, 4	
syscall

la $a0, rightArm
li $v0, 4
syscall

la $a0, leftLeg
li $v0, 4	
syscall

la $a0, rightLeg
li $v0, 4	
syscall
