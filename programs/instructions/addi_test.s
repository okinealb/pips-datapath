# This is a sample assembly program that allows you to test the implementation of an addi instruction in your PIPS datapath.
# This program will begin executing at the first assembly instruction regardless of what label you give it.
addi_test:
  addi $t0, $zero, 0  # Load zero into $t0
  addi $t1, $t0, 1    # Store $t0+1 into $t1 == 1 (0x1)
  addi $t2, $t1, 1    # Store $t1+1 into $t2 == 2 (0x2)
  addi $t3, $t2, 1    # Store $t2+1 into $t3 == 3 (0x3)
  
