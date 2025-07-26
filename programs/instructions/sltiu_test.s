# This is a simple program that tests the implementation of your sltiu instructions.
sltiu_test:
  li    $t3, 0xFFFE
  sltiu $t0, $t3, 0       # Store $t3 < 0 into     $t0 == 0 (0x0)
  sltiu $t1, $t3, 1       # Store $t3 < 1 into     $t1 == 0 (0x0)
  sltiu $t2, $t3, 0xFFFF  # Store $t3 < 65535 into $t2 == 1 (0x1)
  sltiu $t3, $t3, 0xFFFE  # Store $t3 <  into      $t3 == 0 (0x1)
