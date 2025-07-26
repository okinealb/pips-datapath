# This is a simple program that tests the implementation of your li and nor instructions.
nor_test:
  li $s0, 1         # Load a 1 into $s0
  li $s1, 3         # Load a 3 into $s1
  li $s2, 7         # Load a 7 into $s2
  li $s3, 15        # Load a 15 into $s3
  nor $s0, $zero, $s0  # Store $zero nor $s0 into $s0 == -(2^15) + 1 (0xFFFE)
  nor $s1, $zero, $s1  # Store $zero nor $s1 into $s1 == -(2^15) + 3 (0xFFFC)
  nor $s2, $zero, $s2  # Store $zero nor $s2 into $s2 == -(2^15) + 7 (0xFFF8)
  nor $s3, $zero, $s3  # Store $zero nor $s3 into $s3 == -(2^15) + 15 (0xFFF0)
