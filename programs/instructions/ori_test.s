# This is a sample assembly program that allows you to test the implementation of an ori instruction in your PIPS datapath.
# This program will begin executing at the first assembly instruction regardless of what label you give it.
ori_test:
  ori $t0, $zero, 1  # Load 1 into $t0
  ori $t1, $t0, 2    # Store $t0 or 2 into $t1 == 3 (0x1)
  ori $t2, $t1, 4    # Store $t1 or 4 into $t2 == 7 (0x2)
  ori $t3, $t2, 8    # Store $t2 or 8 into $t3 == 15 (0x3)
  
