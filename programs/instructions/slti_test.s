# This is a simple program that tests the implementation of your slti instructions.
slti_test:
  slti $t0, $zero, -1      # Store $zero < -1 into     $t0 == 0 (0x0)
  slti $t1, $zero, 1       # Store $zero < 1 into      $t1 == 1 (0x1)
  slti $t2, $zero, 0x8000  # Store $zero < -32768 into $t2 == 0 (0x0)      
  slti $t3, $zero, 0x7FFF  # Store $zero < 32767 into  $t3 == 1 (0x1)
