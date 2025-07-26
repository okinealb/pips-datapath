# This is a simple program that tests the implementation of the nori instruction.
nori_test:
  nori $t0, $zero, 1  # Store $zero nori $t0 into $t0 == -(2^15) + 1 (0xFFFE)
  nori $t1, $zero, 2  # Store $zero nori $t1 into $t1 == -(2^15) + 2 (0xFFFD)
  nori $t2, $zero, 4  # Store $zero nori $t2 into $t2 == -(2^15) + 4 (0xFFFB)
  nori $t3, $zero, 8  # Store $zero nori $t3 into $t3 == -(2^15) + 8 (0xFFF7)
