nop
lw_test:
  li $sp, 0xf800
  li $s0, 0xffff
  li   $s1, 0xffee
  addi $sp, $sp, -16
  sw   $s0, 12($sp)         
  sw   $s1, 8($sp)
  sb   $s0, 4($sp)
  sb   $s1, 0($sp)



  lb   $t0, 4($sp)      # 0xff
  lb   $t1, 0($sp)      # 0xee
  lw   $t3, 12($sp)     # 0xffee
  lw   $t2, 8($sp)      # 0xffff