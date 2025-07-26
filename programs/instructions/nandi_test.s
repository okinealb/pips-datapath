# This is a sample assembly program that allows you to test the implementation of an nandi instruction in your PIPS datapath.
# This program will begin executing at the first assembly instruction regardless of what label you give it.
nandi_test:
  nandi $t0, $zero, 0  # Store $zero nandi 2 into $t1 == -(2^15) (0xFFFF)
  nandi $t1, $zero, 1  # Store $zero nandi 2 into $t1 == -(2^15) (0xFFFF)
  nandi $t2, $zero, 2  # Store $zero nandi 4 into $t2 == -(2^15) (0xFFFF)
  nandi $t3, $zero, 4  # Store $zero nandi 8 into $t3 == -(2^15) (0xFFFF)
  
