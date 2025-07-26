# This is a simple program that tests the implementation of your sll, srl, sra instructions.
test:
  li $s0, 1         # Load 0000 0000 0000 0001
  li $s1, 0x8001    # Load 1000 0000 0000 0001

  sll $t0, $s0, 1   # Store $s0 << 1 into $t0 == 0000 0000 0000 0010 (0x0002)
  srl $t1, $s0, 1   # Store $s0 >> 1 into $t1 == 0000 0000 0000 0000 (0x0000)
  sra $t2, $s0, 1   # Store $s0 >> 1 into $t2 == 0000 0000 0000 0000 (0x0000)

  sll $t0, $s1, 1   # Store $s0 << 1 into $t0 == 0000 0000 0000 0010 (0x0002)
  srl $t1, $s1, 1   # Store $s0 >> 1 into $t1 == 0100 0000 0000 0000 (0x4000)
  sra $t2, $s1, 1   # Store $s0 >> 1 into $t2 == 1100 0000 0000 0000 (0xc000)