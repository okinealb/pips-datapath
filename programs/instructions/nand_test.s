# This is a simple program that tests the implementation of your li and nand instructions.
nand_test:
  li $s0, 1         # Load a 1 into $s0
  li $s1, 3         # Load a 3 into $s1
  li $s2, 7         # Load a 7 into $s2
  li $s3, 15        # Load a 15 into $s3
  nand $s0, $zero, $s0  # Store $zero nand $s0 into $s0 == -(2^15) (0xFFFE)
  nand $s1, $zero, $s1  # Store $zero nand $s1 into $s1 == -(2^15) (0xFFFF)
  nand $s2, $zero, $s2  # Store $zero nand $s2 into $s2 == -(2^15) (0xFFFF)
  nand $s3, $zero, $s3  # Store $zero nand $s3 into $s3 == -(2^15) (0xFFFF)
