# This is a simple program that tests the implementation of your beq instruction.
beq_test:
  nop                 # No operation
  li  $t0, 4          # load 4 into $t0
  li  $t1, 3          # load 3 into $t1
  j   test            # go to the test


good:
  beq $t0, $t1, good  # jump to good if 4 == 3 (not taken)
  li  $t0, 5          # load 5 into $t0 if it works
  nop                 # do nothing

test:
  beq $t0, $t0, good  # Jump to label good if 4 == 4 (taken)