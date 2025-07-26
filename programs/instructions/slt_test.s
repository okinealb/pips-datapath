# This is a simple program that tests the implementation of your slt instructions.
slt_test:
  li $s0, -1        # Load a -1 into $s0
  li $s1,  1        # Load a  1 into $s1
  li $s2, 0x8000    # Load a -32768 into $s2
  li $s3, 0x7FFF     # Load a  32767 into $s3
  slt $s0, $zero, $s0  # Store $zero < $s0 into $s0 == 0 (0x0)
  slt $s1, $zero, $s1  # Store $zero < $s1 into $s1 == 1 (0x0)
  slt $s2, $zero, $s2  # Store $zero < $s2 into $s2 == 0 (0x1)
  slt $s3, $zero, $s3  # Store $zero < $s3 into $s3 == 1 (0x1)
