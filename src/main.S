	.data
matrix:
    .word 12, 7, 31, 4, 5, 6
    .word 8, 10, 2, 11, 1, 9
    .word 14, 15, 6, 13, 12, 7
    .word 16, 17, 18, 5, 19, 20
    .word 21, 22, 23, 24, 9, 25
    .word 26, 27, 28, 29, 30, 10

minelemstr:
    .asciiz "min element: "

    .text
findMinElement:
    # NOTE: create stack frame
    addi sp, sp, -16 
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)

    mv s0, a0    # s0 = matrix address
    lw s1, 0(s0) # s1 = min = matrix[0][0]
    li s2, 1     # i = 1

    li t0, 6    # t0 = 6 matrix size
loop:
    bge s2, t0, endloop      # if i >= 6 jump to endloop, "bge" is branch if greater or equal

    # NOTE: matrix[i][i] offset calculatin as (i*6 + i)*4 = i*7*4
    li t1, 7
    mul t1, t1, s2           # t1 = i * 7
    slli t1, t1, 2           # t1 *= 4, "slli" is shift left logical immediate
    add t1, s0, t1           # t1 = &matrix[i][i]
    lw t2, 0(t1)             # t2 = matrix[i][i]
    blt t2, s1, updateMin    # if matrix[i][i] < min jump to updateMin, "blt" is branch if less than
    j next_i

updateMin:
    mv s1, t2

next_i:
    addi s2, s2, 1           # i++
    j loop

endloop:
    mv a0, s1                # return min

    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16 # restore stack frame
    ret

    .globl main #? should be visible outside this file
main:
    addi sp, sp, -16
    sw ra, 12(sp)

    la a0, matrix             # matrix address not value
    call findMinElement       # result returned in a0
  	mv t0, a0                 # save result in t0
  
    # print string
    la a1, minelemstr
    li a0, 4
    ecall

    # print integer
    mv a1, t0
    li a0, 1
    ecall

    # print newline
    li a1, 10
    li a0, 11
    ecall

    lw ra, 12(sp)
    addi sp, sp, 16
    li a0, 0
    ret
