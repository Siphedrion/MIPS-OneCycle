#M[0] = 1
#M[1] = n
#M[2] = res

#Convention:  s1 = 1
#             s2 = n
#             s3 = result
#             t0 = i
#             t1 = j
#             t2 = acum
	lw  $s1, 0($zero)           #s1 <- M[0]
	lw  $s2, 4($zero)           #s2 <- M[1]
	or  $s3, $zero, $s1       #t0 <- M[0]
	or  $t0, $zero, $s1       #t0 <- M[0]
	beq $zero, $zero, label1  #if zero = zero then pc <- pc + 4 + 4*9
label2:	or  $t1, $zero, $s1 #t1 <- M[0]
	beq $zero, $zero, label3  #if zero = zero then pc <- pc + 4 + 2*4
label4: add $t2, $t2, $s3   #t2 <- t2 + s3
	add $t1, $t1, $s1         #t1 <- t1 + s1
label3: slt $at, $t0, $t1   #at <- (t0 < t1) ? 1 : 0
	beq $at, $zero, label4    #if at = zero then pc <- pc + 4 -4*4
	or  $s3, $zero, $t2       #s3 <- t2
	and $t2, $zero, $t2       #t2 <- 0
	add $t0, $t0, $s1         #t0 <- t0 + 1
label1: slt $at, $s2, $t0   #at <- (s2 < t0) ? 1 : 0
	beq $at, $zero, label2    #if at = zero then pc <- pc + 4 - 4*11
	sw  $s3, 8($zero)           #M[2] <- s3