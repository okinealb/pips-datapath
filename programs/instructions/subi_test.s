# This is a simple program that tests the implementation of your subi instructions.
subi_test:
  li $t0, 3         # Load a 3 into $t0
  subi $t1, $t0, 1  # Store $t0 - 1 into $t1 == 2 (0x2)
  subi $t2, $t1, 1  # Store $t1 - 1 into $t2 == 1 (0x1)
  subi $t3, $t2, 1  # Store $t2 - 1 into $t3 == 0 (0x0)
