#TEST CODE for Pipelined Processor

#Assign Register values to test with
add $0, $0, $0
addi $1, $0, 1 #R1 = 1
add $0, $0, $0
add $2, $1, $1 #R2 = 2
add $0, $0, $0
addi $3, $3, 1 #R3 = 3
add $0, $0, $0
addi $4, $4, 3 #R4 = 4
add $0, $0, $0

#TEST
mult $2, $3
add $0, $0, $0
mflo $5 #R5 = 6 ******Might need to change from mflo to mfhi to work. Not sure. **********************
add $0, $0, $0
addi $0, $0, 1 # $R0 = 0 . Should not be allowed to write into R0
add $0, $0, $0
sll $6, $5, 1 # R6 = 12
add $0, $0, $0
srl $7, $6, 2 # R7 = 3
add $0, $0, $0
sra $8, $1, 4 # R8 = 0xF0000000
add $0, $0, $0
sub $9, $8, $1 # R9 = 0xEFFFFFFF
add $0, $0, $0
lui $10, 44221 #R10 = 0xACBD0000 . 44221 = 0xACBD
add $0, $0, $0

beq $1, $1, Divide
add $0, $0, $0

PostDivide: add $0, $0, $0
			bne $0, $1, SetLessThan



Divide: add $0, $0, $0
		div $5, $4 #6/4 = 1 R2
		add $0, $0, $0
		mfhi $11 #R11 = 2 --it takes the remainder
		add $0, $0, $0
		mflo $12 #R12 = 1 --it takes the quotient
		add $0, $0, $0
		j PostDivide

SetLessThan: add $0, $0, $0
			slt $13, $0, $1 #R13 = 1 because 0<1
			add $0, $0, $0
			slti $14, $0, 1 #R14 = 0 because 0!<1
			j Exit


Exit: add $0, $0, $0

#FINAL REGISTER VALUES
#R0 = 0x00000000
#R1 = 0x00000001
#R2 = 0x00000002
#R3 = 0x00000003
#R4 = 0x00000004
#R5 = 0x00000006
#R6 = 0x0000000C
#R7 = 0x00000003
#R8 = 0xF0000000
#R9 = 0xEFFFFFFF
#R10 = 0xACBD0000
#R11 = 0x00000002
#R12 = 0x00000001
#R13 = 0x00000001
#R14 = 0x00000000
