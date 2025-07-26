# This is a simple program that tests the implementation of your li and and instructions.
and_test:
  li $s0, 1         # Load a 1 into $s0
  li $s1, 3         # Load a 3 into $s1
  li $s2, 7         # Load a 7 into $s2
  li $s3, 15        # Load a 15 into $s3
  and $s1, $s0, $s1  # Store $s0 and $s1 into $s1 == 1  (0x1)
  and $s2, $s1, $s2  # Store $s1 and $s2 into $s2 == 1  (0x1)
  and $s3, $s2, $s3  # Store $s2 and $s3 into $s3 == 1  (0x1)

