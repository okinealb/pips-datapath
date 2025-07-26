# This is a simple program that tests the implementation of your sltu instructions.
sltu_test:
  li $s0, 0        # Load a 0 into $s0
  li $s1, 1        # Load a 1 into $s1
  li $s2, 0xFFFF   # Load a 65535 into $s2
  li $s3, 0xFFF8   # Load a  65528 into $s3
  sltu $s0, $s3, $s0  # Store $s3 < $s0 into $s0 == 0 (0x0)
  sltu $s1, $s3, $s1  # Store $s3 < $s1 into $s1 == 0 (0x0)
  sltu $s2, $s3, $s2  # Store $s3 < $s2 into $s2 == 1 (0x1)
  sltu $s3, $s3, $s3  # Store $s3 < $s3 into $s3 == 0 (0x1)
