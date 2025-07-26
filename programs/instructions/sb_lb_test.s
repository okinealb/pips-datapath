# This is a simple program that tests the implementation of your li, sw, lb instructions.
nop
b_lb_test:
  li   $sp, 0xf800    # Set up the stack
  li   $a0, 46       # Set first input m = 46
  li   $a1, 15        # Set second input n = 15
  jal  gcd            # Call procedure gcd(46,15)
  addi $t0, $v0, 0    # Move result to input
  addi $a0, $v0, 0    # Move result to input
  li   $a1, 15
  jal  gcd            # Call procedure gcd(1, 15)
  addi $t1, $v0, 0    # Move result to input
  j    end            # end program
  # END PROGRAM

gcd:
  addi $sp, $sp, -8		# Make room on the stack
  sb   $ra, 4($sp)		# Store the return address
  sb   $a1, 0($sp)		# Store the input n
  beq $a1, $zero, exit_gcd 		# Branch if we have the base case
  jal  remainder 		    # Call the remainder procedure
  lb   $a0, 0($sp) 		# Set m = n
  addi $a1, $v0, 0			# Set n = remainder(m,n)
  jal  gcd 			# gcd(n, remainder(m,n))
  lb   $ra, 4($sp)		# Load the return address
  addi $sp, $sp, 8 		# Restore the stack pointer
  jr   $ra			# Return to caller
exit_gcd: # Exit the procedure
  lb   $ra, 4($sp)		# Load the return address
  addi $sp, $sp, 8 		# Restore the stack pointer
  addi $v0, $a0, 0 		# Store the result
  jr   $ra                      # Return to caller

remainder:
  j    if_rem			# Branch to beginning of loop
loop_rem:
  sub  $a0, $a0, $a1 		# a = a - b
if_rem:
  slt  $t0, $a0, $a1 		# (a < b) = !(a >= b)
  beq $t0, $zero, loop_rem 		# Branch if terminating condition
exit_remainder: # Exit the procedure
  addi $v0, $a0, 0 		  # Move 'a' into the result
  jr   $ra			# Return to caller

end:
  nop          # ending the program