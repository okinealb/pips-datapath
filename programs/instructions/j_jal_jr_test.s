# This is a simple program that tests the implementation of your j, jal, and jr instructions.
j_jal_jr_test:
  nop                 # No operation
  li  $t0, 0          # Load in 0 to $t0 = 0
  j   one             # Jump to label one
two:
  li   $t1, 8         # Load in 8 to $t1 = 8
  jr   $ra            # Return to caller
one:
  addi $t0, $t0, 4    # Add 4 to $t0 = 4
  jal  two            # Jump and link to procedure two
  nop                 # Do nothing