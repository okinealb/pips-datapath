# This is a simple program that tests the implementation of your li and xor instructions.
xor_test:
  li $s0, 1         # Load a 1 into $s0
  li $s1, 2         # Load a 2 into $s1
  li $s2, 4         # Load a 4 into $s2
  li $s3, 8         # Load a 8 into $s3
  xor $s0, $zero, $s0  # Store $zero xor $s0 into $s0 == 1 (0x1)
  xor $s1, $zero, $s1  # Store $zero xor $s1 into $s1 == 2 (0x2)
  xor $s2, $zero, $s2  # Store $zero xor $s2 into $s2 == 4 (0x4)
  xor $s3, $zero, $s3  # Store $zero xor $s3 into $s3 == 8 (0x8)
