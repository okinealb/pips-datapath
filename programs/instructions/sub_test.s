# This is a simple program that tests the implementation of your li and sub instructions.
sub_test:
  li $s0, 12         # Load a 12 into $s0
  li $s3,  4         # Load a 4 into $s3
  sub $s1, $s0, $s3  # Store $s0 - $s0 into $s1 == 8 (0x8)
  sub $s2, $s1, $s3  # Store $s1 - $s1 into $s2 == 4 (0x4)
  sub $s3, $s2, $s3  # Store $s2 - $s2 into $s3 == 0 (0x0)

