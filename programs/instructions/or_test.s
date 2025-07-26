# This is a simple program that tests the implementation of your li and or instructions.
or_test:
  li $s0, 1         # Load a 1 into $s0
  li $s1, 3         # Load a 3 into $s1
  li $s2, 7         # Load a 7 into $s2
  li $s3, 15        # Load a 15 into $s3
  or $s1, $s0, $s1  # Store $s0 or $s1 into $s1 == 3  (0x3)
  or $s2, $s1, $s2  # Store $s1 or $s2 into $s2 == 7  (0x7)
  or $s3, $s2, $s3  # Store $s2 or $s3 into $s3 == 15 (0xF)

