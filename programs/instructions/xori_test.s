# This is a simple program that tests the implementation of your xori instructions.
xori_test:
  xori $t0, $zero, 1  # Store $zero xor $t0 into $t0 == 1 (0x1)
  xori $t1, $zero, 3  # Store $zero xor $t1 into $t1 == 3 (0x3)
  xori $t2, $zero, 7  # Store $zero xor $t2 into $t2 == 7 (0x7)
  xori $t3, $zero, 15 # Store $zero xor $t3 into $t3 == 15 (0xF)
