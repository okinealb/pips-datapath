# This is a simple program that tests the implementation of your li andi andi instructions.
andi_test:
  li $t0, 1          # Load a 1 into $t0
  andi $t1, $t0, 3   # Store $t0 andi $t1 into $t1 == 1  (0x1)
  andi $t2, $t1, 7   # Store $t1 andi $t2 into $t2 == 1  (0x1)
  andi $t3, $t2, 15  # Store $t2 andi $t3 into $t3 == 1  (0x1)

