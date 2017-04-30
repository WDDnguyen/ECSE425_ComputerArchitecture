#TEST CODE for Pipelined Processor

#Assign Register values to test with
addi $1, $0, 1 #R1 = 1
add $2, $1, $1 #R2 = 2
addi $3, $3, 1 #R3 = 3
addi $4, $4, 3 #R4 = 4

#TEST
mult $2, $3
mflo $5 #R5 = 5 ******Might need to change from mflo to mfhi to work. Not sure. **********************
addi $0, $0, 1 # $R0 = 0 . Should not be allowed to write into R0



#FINAL REGISTER VALUES
#R0 = x00000000
#R1 = x00000001
#R2 = x00000002
#R3 = x00000003
#R4 = x00000004
#R5 = x00000006
