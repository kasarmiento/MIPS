.data 
	title:	.asciiz "\n================== CPU 9000 ==================\n     A computer program from the future.\n\n"
	intro:	.asciiz "Please select an option: \n1. Add two numbers. \n2. Multiply four numbers. \n3. Compute char frequency & print reverse. \n4. Fibonacci Funk. \n5. Exit Program. \n==> "
	invld:	.asciiz "\nINVALID OPTION.\n\n"
	
	addIntro:
		.asciiz "\n======== ADDITION PROCEDURE ========\n    Adds two numbers together. \n\nPlease enter your first number: "
	addNext:
		.asciiz "Please enter your second number: "
	addSum:
		.asciiz "\n==> YOUR SUM: "
		
	multiplyIntro:
		.asciiz "\n======== MULTIPLICATION PROCEDURE ========\n    Multiplies four numbers together. \n\nPlease enter your first number: "
	multiplyThird:
		.asciiz "Please enter your third number: "
	multiplyFourth:
		.asciiz "Please enter your fourth number: "
	product:
		.asciiz "\n==> YOUR PRODUCT: "
		
	ssOps:
		.asciiz "\n=========== STRING OPERATIONS ============\n    Accepts a (max 30 character) string\n  and calculates the frequencies of each\n  character. Then prints the same string\n               in reverse.\n\nPlease enter your string (MAX 30 CHARS): \n"
	labCar:	.asciiz "\nCHARACTER FREQUENCY: \n\n"
	eq: 	.asciiz " = "
	br:	.asciiz "\n"
	
	printRev:
		.asciiz "\n============= STRING REVERSE ============\n  \n      and prints it in reverse.\n\nPlease enter your string (MAX 30 CHAR):\n"
	stringStorage:
		.space 32  # save 32 bytes	
	revResult:
		.asciiz "\nYOUR STRING IN REVERSE: "
		
	iiIntro:
		.asciiz "\n======== THE FIBONACCI SEQUENCE ========\n  The Fibonacci Sequence is Nature's \n          numbering system.\n\nPlease enter a number: "
	iiReturn:
		.asciiz "\nYour call to Fibonacci returns: \n "
	ii:	.asciiz " "
	
	zz:	.asciiz "input 264: "
	zzStorage:
		.space 32 # save 32 bytes
	zzValue:
		.asciiz "Davarpanah\n"
		
	aloe:	.asciiz "\nNumber of bytes to allocate: "
	idStorage:
		.space 32  # save 32 bytes	
	yourID:	.asciiz "\nYour identity: "
	success:
		.asciiz "\nThe memory was allocated at address "
	confirm:
		.asciiz "\n\nIDENTITY IN HEAP"
	
	thnx:	.asciiz "\n\nThank you for using the CPU 9000 computer program.\nGoodbye.\n"

	
.text
main:

	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, title			# param = string addr
	syscall				# print title
	
start:	addi $t1, $zero, 1		# t1 = 1
	addi $t2, $zero, 2		# t2 = 2
	addi $t3, $zero, 3		# t3 = 3
	addi $t4, $zero, 4		# t4 = 4
	addi $t5, $zero, 5		# t5 = 5
	addi $t9, $zero, 264		# t9 = 264
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, intro			# param = string addr
	syscall				# print menu options
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# read user's input
	add  $t0, $zero, $v0		# t0 = user's option
	
	beq  $t0, $t1, op_1		# if user = 1, goto 'op_1'
	beq  $t0, $t2, op_2		# if user = 2, goto 'op_1'		
	beq  $t0, $t3, op_3		# if user = 3, goto 'op_1'
	beq  $t0, $t4, op_4		# if user = 4, goto 'op_1'
	beq  $t0, $t5, op_5		# if user = 5, goto 'op_1'
	beq  $t0, $t9, secret_op	# if user = 264, goto 'secretop'
	bne  $t0, $t9, wrong		# if user != 264, goto 'wrong'
	

op_1:	jal addMe			# jump to procedure 'addMe'
	add $s0, $zero, $v0		# s0 = SUM
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, addSum		# param = string addr
	syscall				# print "YOUR SUM: "
	
	addi $v0, $zero, 1		# syscall 1 = print_int
	add $a0, $zero, $s0		# param = s0
	syscall				# print SUM value
	j exit				# goto 'exit'
		
op_2:	jal multiply			# jump to procedure 'multiply'
	add $s0, $zero, $v0		# s0 = PRODUCT
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, product		# param = string addr
	syscall				# print "YOUR PRODUCT: "
	
	addi $v0, $zero, 1		# syscall 1 = print_int
	add $a0, $zero, $s0		# param = s0
	syscall				# print PRODUCT value
	j exit				# goto 'exit'
	
op_3:	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, ssOps			# param = string addr
	syscall				# print String Operations intro & asks user for a string
	
	addi $v0, $zero, 8		# syscall 8 = read_string
	la   $a0, stringStorage		# param = destination of inputted string
	addi $a1, $zero, 32		# param = size of storage
	syscall				# receive user's string input
	
	la   $a0, stringStorage		# param a0 = string's addr 
	jal  char_freq			# jump to procedure 'char_freq'
	
	la   $a0, stringStorage		# param a0 = string's addr 
	jal  print_rev			# jump to procedure 'print_rev'
	
	j exit				# goto 'exit'

op_4:	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, iiIntro		# param = string addr
	syscall				# print Fibonacci intro & ask for number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# will wait for user input
	add $s0, $zero, $v0		# s0 = n
	
	addi	$v0, $zero, 4		# syscall 4 = print_string
	la	$a0, iiReturn		# param = address of string
	syscall				# print "Your call to fibonacci: "
	
	add 	$a0, $zero, $s0		# param = n
	jal	printFibonacci		# jump to procedure 'printFibonacci'
	
	j exit
	
op_5:	j exit

secret_op:
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, zz			# param = address of string
	syscall				# print "input 264? "
	
	addi $v0, $zero, 8		# syscall 8 = read_string
	la   $a0, zzStorage		# param = destination of inputted string
	addi $a1, $zero, 32		# param = size of storage
	syscall				# receive user's password
	
	jal  strcompare			# jump to procedure 'compare'
	add  $t0, $zero, $v0		# t0 = 0 or 1, 0 = incorrect, 1 = pass
	
	beqz $t0, wrong			# branch if t0 = 0/if incorrect password
	jal  dynamicID			# jump to procedure 'dynamicID'
	
	j exit
	
wrong: 	addi $v0, $0, 4			# syscall 4 = print_str
	la $a0, invld			# load address of string into a0
	syscall	
	j start

exit:	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, thnx			# param = string addr
	syscall				# print "Thank you"
	
	ori $v0, $0, 10			# syscall 10 = exit program
	syscall
	
############################# ADDITION PROCEDURE ############################# 
	
addMe:	
	addi $sp, $sp, -4		# allocate stack space for 1 word
	sw   $s0, 0($sp)		# s0 saved on stack
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, addIntro		# param = string addr
	syscall				# print addition introduction & ask for 1st number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's 1st number
	add  $s0, $zero, $v0		# s0 = 1st number
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, addNext		# param = string addr
	syscall				# ask for 2nd number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's 2nd number
	add  $v0, $v0, $s0		# v0 = 2nd number + 1st number
			
	addi $sp, $sp, -4		# deallocate stack space
	lw   $s0, 0($sp)		# s0 = orig value
	jr   $ra			# return to main
	

########################## MULTIPLICATION PROCEDURE ########################## 

multiply:
	addi $sp, $sp, -16		# allocate stack space for 1 word
	sw   $s0, 0($sp)		# s0 saved on stack
	sw   $s1, 4($sp)		# s1 saved on stack
	sw   $s2, 8($sp)		# s2 saved on stack
	sw   $s3, 12($sp)		# s3 saved on stack
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, multiplyIntro		# param = string addr
	syscall				# print multiply introduction & ask for 1st number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's 1st number
	add  $s0, $zero, $v0		# s0 = 1st number
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, addNext		# param = string addr
	syscall				# ask for 2nd number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's 2nd number
	add  $s1, $zero, $v0		# s1 = 2nd number
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, multiplyThird		# param = string addr
	syscall				# ask for 3rd number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's third number
	add  $s2, $zero, $v0		# s2 = 3rd number
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, multiplyFourth	# param = string addr
	syscall				# ask for fourth number
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's fourth number
	add  $s3, $zero, $v0		# s3 = 4th number

	mul  $v0, $s0, $s1		# v0 = a * b
	mul  $v0, $v0, $s2		# v0 *= c
	mul  $v0, $v0, $s3		# v0 *= d
	
	lw   $s0, 0($sp)		# s0 = orig value
	lw   $s1, 4($sp)		# s1 = orig value
	lw   $s2, 8($sp)		# s2 = orig value
	lw   $s3, 12($sp)		# s3 = orig value
	addi $sp, $sp, -16		# deallocate stack space
	jr   $ra			# jump back to main
	
	
######################## PRINT CHARACTER FREQUENCIES ######################## 

char_freq:
	addi $sp, $sp, -232		# allocate stack space for int occurences[58]	
	add  $t9, $zero, $sp		# t9 = addr of occurences[58]
	
	addi $sp, $sp, -24		# allocate more stack space
	sw   $s0, 0($sp)		# s0 saved on stack
	sw   $s1, 4($sp)		# s1 saved on stack
	sw   $s2, 8($sp)		# s2 saved on stack
	sw   $s3, 12($sp)		# s3 saved on stack
	sw   $s4, 16($sp)		# s4 saved on stack
	sw   $ra, 20($sp)		# ra saved on stack
	
	add  $s0, $zero, $t9		# s0 = addr of occurences[]
	add  $s1, $zero, $s0		# *s1 = *p occurences
	
	add  $s2, $zero, $a0		# s2 = addr of string
	add  $s3, $zero, $s2		# *s3 = *p string
	
	add  $a0, $zero, $s2		# param a0 = addr of string
	jal  strlen			# calculate length of string at address in a0
	add  $s4, $zero, $v0		# s4 = string length 
	
	addi $t0, $zero, 0		# t0 = i = 0
	addi $t1, $zero, 58		# t1 = 58
	addi $t3, $zero, 0
initfor:
	bge  $t0, $t1, cnext		# if i >= 58, move onto next loop
	sb   $t3, 0($s1)		# occurences[*s1] = 0
	addi $t0, $t0, 1		# i++
	addi $s1, $s1, 4		# *s1++
	j    initfor			# loop back to 'initfor'

cnext:
	addi $t0, $zero, 0		# reset i
	add  $s1, $zero, $s0		# reset *s1
ccount:
	bge  $t0, $s4, clast		# i >= string length
	addi $t1, $zero, 0		# reset balue of t1
	lb   $t1, 0($s3)		# t1 = asciival = string[i]
	addi $t2, $t1, -65		# t2 = index that I need to increment = asciival - 65
	addi $t8, $zero, 4
	mul  $t2, $t2, $t8
	add  $s1, $zero, $s0		# reset s1 (pointer to occurences)
	add  $s1, $s1, $t2		# tru index of occurences
	lb   $t3, 0($s1)		# t3 = numOfOccurence = occurences[index]
	addi $t3, $t3, 1		# value in occurences[index]++
	sb   $t3, 0($s1)		# restore updated value in occurences[index]
	
	addi $t0, $t0, 1		# i++
	addi $s3, $s3, 1		# *s3++
	j    ccount			# loop back to 'ccount'

clast: 	addi $t0, $zero, 0		# reset i
	add  $s1, $zero, $s0		# reset *s1
	add  $s3, $zero, $s2		# reset *s3
	
	addi $v0,$zero, 4		# syscall 4 = print_string
	la   $a0, labCar		# print this label's location
	syscall
	
	addi $t1, $zero, 58		# t1 = 58
cprint:	bge  $t0, $t1, cexit		# if i >= 58, move onto next loop
	addi $t2, $t0, 65		# t2 = adjusted char ascii value = i + 65
	#add  $s1, $s1, $t0		# *s1 = occurences[i]
	lb   $t3, 0($s1)		# t3 = occurences[i] value
	beqz $t3, cnone			# goto 'cnone' if no occurence
	
	addi $v0, $zero, 11		# syscall 11 = print_char
	add  $a0, $zero, $t2		# param = char value
	syscall				# print character
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, eq			# param = string to print
	syscall				# prints an equal sign
	
	addi $v0, $zero, 1		# syscall 1 = print_int
	add  $a0, $zero, $t3		# param = occurences[i]
	syscall				# print num of occurences
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, br			# param = string to print
	syscall				# prints line break
	
cnone:	addi $t0, $t0, 1		# t0++
	addi $s1, $s1, 4		# *s1 ++
	j 	cprint

cexit: 	lw   $s0, 0($sp)		# load s0
	lw   $s1, 4($sp)		# load s1
	lw   $s2, 8($sp)		# load s2
	lw   $s3, 12($sp)		# load s3
	lw   $s4, 16($sp)		# load s4
	lw   $ra, 20($sp)		# load ra
	addi $sp, $sp, 20		# deallocate some stack space	
	addi $sp, $sp, 232		# deallocate more stack space	
	jr   $ra			# jump back to main

################### HELPER METHOD: STRLEN ###################

strlen:
	add  $t0, $zero, $a0		# t0 = string address
	addi $t1, $zero, 0		# t1 = counter = 0
	add  $t2, $zero, $t0		# t2 = *p string
swhile:	lb   $t3, 0($t2)		# t3 = char at *p
	beqz $t3, sdone			# if t3 = 0 = '\0'
	addi $t1, $t1, 1		# t1++
	addi $t2, $t2, 1		# *p += 1
	j    swhile
	
sdone:	addi  $v0, $t1, -1
	jr   $ra
	

########################## PRINT IN REVERSE ########################## 

print_rev:
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, revResult		# param = string addr
	syscall				# print "Your Result"
	
	la   $t0, stringStorage		# t0 = *p for stringStorage[0]
	addi $t1, $t0, 32		# t1 = *p II = i = starting at stringStorage[30]
	
rev_while:	
	blt  $t1, $t0, rev_done		# if t1 reaches base address
	lb   $s0, 0($t1)		# s0 = byte in str[backwardIndex]
	
	addi $v0, $zero, 11		# syscall 4 = print_character
	la   $a0, 0($s0)		# param = string byte address
	syscall				# print stringStorage[i]
	
	addi $t1, $t1, -1		# backwardIndex--
	j    rev_while
	
rev_done:	
	jr   $ra				

	
############################# FIBONACCI ############################# 

fibonacci:
	addi	$sp, $sp, -12		# allocate space on the stack
	sw	$ra, 0($sp)		# 'fibonacci' is a non-leaf procedure, therefore save return address
	sw	$s0, 4($sp)		# save s0
	sw	$s1, 8($sp)		# save s1
		
	add	$s0, $zero, $a0		# s0 = n
	add	$t0, $zero, $t0		# t0 = 2
	bge	$s0, $t0, felse		# if n >= 2, go 'else'
	addi 	$v0, $zero, 1		# otherwise, return 1
	j	fexit			# go 'exit'
felse:
	addi	$a0, $s0, -1		# param = n - 1
	jal 	fibonacci		# call recursive 'fibonacci'
	add	$s1, $zero, $v0		# s1 = return value
	
	addi	$a0, $s0, -2		# param = n - 2
	jal 	fibonacci		# call recursive 'fibonacci
	add	$v0, $v0, $s1		# v0 += return
fexit:
	lw	$ra, 0($sp)		# reload return address
	lw	$s0, 4($sp)		# reload s0
	lw	$s1, 8($sp)		# reload s1
	addi	$sp, $sp, 12		# deallocate stack space
	jr	$ra
	

printFibonacci:
	addi	$sp, $sp, -16		# allocate space on the stack
	sw	$ra, 0($sp)		# 'printFibonacci' is a non-leaf procedure, therefore save return address
	sw	$s0, 4($sp)		# save s0
	sw	$s1, 8($sp)		# save s1
	sw	$s2, 12($sp)		# save s2
	
	add	$s0, $zero, $a0		# s0 = n
	addi 	$s1, $zero, 0		# s1 = index
	addi	$s2, $zero, 0		# s2 = current
	
pwhile:	add	$a0, $zero, $s1		# param = index
	jal 	fibonacci		# call 'fibonacci'
	add	$s2, $zero, $v0		# current = fibonacci(index)
	
	bgt	$s2, $s0, pexit		# if current > n, go 'pexit'
	
	addi	$v0, $zero, 1		# syscall 1 = print_int
	add	$a0, $zero, $s2		# param = current
	syscall
	
	addi	$v0, $zero, 4		# syscall 4 = print_string
	la	$a0, ii			# param = string address
	syscall				# print " "
	
	addi	$s1, $s1, 1		# index++
	j	pwhile			
	
pexit:	lw	$ra, 0($sp)		# reload return address
	lw	$s0, 4($sp)		# reload s0
	lw	$s1, 8($sp)		# reload s1
	lw	$s2, 12($sp)		# reload s2
	addi	$sp, $sp, 12		# deallocate stack space
	jr	$ra
	

##################### HELPER METHOD: STRCOMPARE ##################### 

strcompare:
	addi $t1, $zero, 0		# t1 = c1
	addi $t2, $zero, 0		# t2 = c2
	addi $t0, $zero, 1		# t3 = equal
	
	la   $t3, zzStorage		# *t3 = user's
	la   $t4, zzValue		# *t4 = actual
scwhile:
	lb   $t5, 0($t3)		# str1[c1]	
	lb   $t6, 0($t4)		# str2[c2]
	bnez $t5, scnext		# branch if byte t5 != 0
scnext: beqz $t6, screturn		# branch if byte t6 == 0
	beq  $t5, $t6, scinwhile	# if t5 = t6, just increment
	addi $t0, $zero, 0		# otherwise change equal = 0
scinwhile:
	addi $t3, $t3, 1		# c1++
	addi $t4, $t4, 1 		# c2++
	j    scwhile			# loop back to while
screturn:
	add  $v0, $zero, $t0		# return equal
	jr   $ra


############################# DYNAMIC ID #############################

dynamicID:

	addi $sp, $sp, -24		# move stack pointer down 6 words
	sw   $ra, 0($sp)		# 'dynamicID' is a non-leaf procedure, therefore save return address
	sw   $s0, 4($sp)		# save s0
	sw   $s1, 8($sp)		# save s1
	sw   $s2, 12($sp)		# save s2
	sw   $s3, 16($sp)		# save s3
	sw   $s4, 20($sp)		# save s4	

	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, aloe			# param = string addr
	syscall				# print "Num of bytes to allocate?"
	
	addi $v0, $zero, 5		# syscall 5 = read_int
	syscall				# receive user's integer input
	add  $t9, $zero, $v0		# t9 = num of bytes to allocate
	
	addi $v0, $zero, 9		# syscall 9 = sbrk (dynamically allocate new space)
	add  $a0, $zero, $t9		# param = num of bytes to allocate
	syscall				# v0 contains address of allocated space
	
	add  $s1, $zero, $v0		# s1 = base address of dynamic space
	add  $s2, $zero, $s1		# *s2 = *p to dynamic space
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, yourID		# param = string addr
	syscall				# print "Your ID: "
	
	addi $v0, $zero, 8		# syscall 8 = read_string
	la   $a0, idStorage		# param = where to store inputted string
	addi $a1, $zero, 32		# param = size of space
	syscall				# wait for user's input
	
	la   $s3, idStorage		# s3 = base address of user's string
	add  $s4, $zero, $s3		# *s4 = *p to user's string	
	
	## *s2 = dynamic space,  *s4 = user's string
	
	addi $s0, $zero, 0		# s0 = counter
	
	add  $a0, $zero, $s3		# copy base address of user's string into a0
	jal  strlen			# calculate the length of the user's string
	add  $t0, $zero, $v0		# t0 = IDlen = calculated string length of user's string
	addi $t0, $t0, -1		# IDlen = strlen(user's calculated string) - 1
	
	addi $t1, $zero, 0		# t1 = i
	addi $t2, $zero, 32		# t2 = x = 32
idfor:	bge  $t1, $t2, idofor		# if i >= x, goto 'idofor'
	ble  $s0, $t0, idinloop		# if counter <= IDlen, goto 'idcont'
	addi $s0, $zero, 0		# reset counter = 0
idinloop:
	add  $s4, $s4, $s0		# *s4 = id[counter]
	lb   $t3, 0($s4)		# byte in id[counter]
	add  $s2, $s2, $t1		# *s2 = heap[i]
	sb   $t3, 0($s2)		# t3 = byte in heap[i]
	
	addi $s0, $s0, 1		# counter++
	addi $t1, $t1, 1		# i++
	j    idfor			# loop back to 'idfor'
idofor:
	addi $t1, $zero, 0		# reset i = 0	
	addi $t2, $zero, 32		# reset x = 32
	add  $s2, $zero, $s1		# reset *s2
	add  $s4, $zero, $s3		# reset *s4
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, success		# param = string to print
	syscall				# print 'success' message
	
	addi $v0, $zero, 1		# syscall 1 = print_int
	add  $a0, $zero, $s1		# param = address of allocated space
	syscall				# print address
	
	addi $v0, $zero, 4		# syscall 4 = print_string
	la   $a0, confirm		# param = string to print
	syscall				# print 'confirm' message
	
	addi $v0, $zero, 10		# syscall 10 = exit program
	syscall				# EXIT

idealocate:	
	lw   $ra, 0($sp)		# load ra
	lw   $s0, 4($sp)		# load s0
	lw   $s1, 8($sp)		# load s1
	lw   $s2, 12($sp)		# load s2
	lw   $s3, 16($sp)		# load s3
	lw   $s4, 20($sp)		# load s4
	addi $sp, $sp, 24		# move stack pizza
	
	jr   $ra
