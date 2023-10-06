#M[0] = n
#M[3] = v[0]
        addi    $s2, $zero, 3       # s2 = &v[0]
        lw      $s3, 0($zero)       # s3 = n
        add     $s0, $zero, $zero   # i = 0
for1tst:slt     $t0, $s0, $s3       # t0 = (i < n)?1:0
        beq     $t0, $zero, exit1   # termina for1 si (i >= n)
        addi    $s1, $s0, -1        # j = i-1
for2tst:slti    $t0, $s1, 0         # t0 = (j < 0)?1:0
        bne     $t0, $zero, exit2   # termina for2 si (j < 0)
        sll		$t1, $s1, 2         # t1 = j*4
        add     $t2, $s2, $t1       # t2 = &v[j]
        lw      $t3, 0($t2)         # t3 = v[j]
        lw      $t4, 4($t2)         # t4 = v[j+1]
        slt     $t0, $t4, $t3       # t0 = (v[j+1] < v[j])?1:0
        beq     $t0, $zero, exit2   # termina for2 interno si (v[j+1] >= v[j])
        sw      $t4, 0($t2)         # v[j] = t4
        sw      $t3, 4($t2)         # v[j+1] = t3
        addi    $s1, $s1, -1        # j -= 1
        j		for2tst             # for2: ciclo interno
exit2:  addi    $s0, $s0, 1         # i += 1 
        j       for1tst             # for1: ciclo externo
exit1:  addi    $zero, $zero, $zero # fin