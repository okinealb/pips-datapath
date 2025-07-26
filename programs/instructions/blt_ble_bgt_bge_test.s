# This is a simple program that tests the implementation of your blt!, ble!, bgt!, bge! instructions.
nop # first instruction does not excuse
test:
  j   last                      # Start from the bottom

fourth_last:
  li   $s3, 1                   # $s3 = 1  (0x0001)             
  li   $t3, 2                   # $t3 = 2  (0x0002)             
  bgt! $t3, $zero, pass         # $t3 = 1  (0x0001)             
  j    fail                     # Jump to fail branch if invalid

third_last:
  li   $s2, 1                   # $s2 = 1  (0x0001)             
  li   $t2, 2                   # $t2 = 2  (0x0002)             
  bge! $t2, $t2, fourth_last    # $t2 = 0  (0x0000)             
  j    fail                     # Jump to fail branch if invalid

second_last:
  li   $s1, 1                   # $s1 = 1  (0x0001)             
  li   $t1, -2                  # $t1 = -2 (0xfffe)             
  ble! $t1, $t1, third_last     # $t1 = 0  (0x0000)             
  j    fail                     # Jump to fail branch if invalid

last:
  li   $s0, 1                   # $s0 = 1  (0x0001)             
  li   $t0, -2                  # $t0 = -2 (0xfffe)             
  blt! $t0, $zero, second_last  # $t0 = 1  (0x0001)             
  j    fail                     # Jump to fail branch if invalid

fail:
  li $t0, -5                    # Set to -5 if failed any test
  j 0xff00                      # Stop execution

pass:
  li $t0, 5                     # Set to 5 is passed every test
  j 0xff00                      # Stop execution