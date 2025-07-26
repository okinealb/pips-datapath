# Continuously read in one-digit addition equations, printing
# each result in the terminal
.constant HALT      0xff00
.constant TERM      0xff10
.constant KBD       0xff20
.constant STACK_TOP 0xf800
.constant NEWLINE   0x0a
.constant ZERO      0x30

nop # First instruction does not execute
main:
	li 	 $s0, TERM 				# Address of the terminal output for memory-mapped I/O
	li 	 $s1, KBD 				# Address of the keyboard input for memory-mapped I/O
	li 	 $s2, NEWLINE			# Load in newline character
	li 	 $s3, 0						# command = false, wait for first input
	li 	 $sp, STACK_TOP		# Predefined initial stack address
loop:
	lb 	 $t0, 0($s1)				# Load a character from the keyboard
  beq  $t0, $zero, loop		# If it is the null terminator, start over
branch_to_case:
	li 	 $t1, '+'					      # Load in '+' character
	beq  $t0, $t1, if_plus	    # Branch if on the plus sign character
	beq  $t0, $s2, if_newline	  # Branch if on the newline character
	beq  $s3, $zero, if_first		# Branch and set first input (before 1st input)
	bne  $s3, $zero, if_second	# Branch and set second input (after 1st input)

if_first:
	addi $a0, $t0, 0				    # Set the first input
	li 	 $s3, 1									# command = true, wait for plus and second input
	j 	 loop						    		# Start over
if_plus:
	j 	 loop						    		# Start over
if_second:
	addi $a1, $t0, 0				    # Set the second input
	j 	 loop			          		# Start over

if_newline:
	beq  $s3, $zero, end				# Branch to end if there is no command
compute:
  li   $s3, 0                 # command = false, resetting the calculator
	jal  sum						        # Call the procedure sum(first,second)
  addi $a0, $v0, 0            # Move the sum result into input register
  jal  print_decimal_number   # Call the procedure print_decimal_number(sum)
	sb   $s2, 0($s0)      	    # Print newline
	j 	 loop						    		# Start over
end:
	j 	 HALT 							    # Enable halt pin and stop the PC incrementing

# description: Return the result of the two numbers given
# preconditions:  $a0-$a1: the two numbers (ascii)
# postconditions: $v0: the sum of the numbers
sum:
	subi $t0, $a0, ZERO		# Convert the first input to an integer
	subi $t1, $a1, ZERO		# Convert the second input to an integer
	add  $v0, $t0, $t1		# Return the sum in the output register
  jr   $ra              # Return to caller

# description: Print the given number to the terminal
# preconditions:  $a0: the number to print
#                 $s0: the address of the terminal
# postconditions: the number is printed to the terminal
print_decimal_number:
  bne  $a0, $zero, else_prnt  # Branch if in recursive case
if_prnt:
  li   $t0, ZERO              # Load in '0' character
  sb   $t0, 0($s0)            # Print '0'
  jr   $ra                    # Return to caller
else_prnt:
  push $ra                    # Store the return address
  push $a0                    # Store the input
  li   $a1, 10                # Set the second input
  jal  remainder              # Call procedure remainder(n,10)
  pop  $a0                    # Load the input from the stack
  push $v0                    # Store digit on the stack
  slt  $t1, $v0, $a0          # (n > digit)?
  beq  $t1, $zero, exit_prnt  # Branch if we don't have the condition
if_inner:
  li   $a1, 10                # Set the second input
  jal  quotient               # Call procedure quotient(n,10)
  addi $a0, $v0, 0            # Set the input
  jal  print_decimal_number   # Call procedure print_decimal_number(n/10)
exit_prnt:
  pop  $t0                    # Load digit from the stack
  addi $t0, $t0, ZERO         # Set the char digit + '0'
  sb   $t0, 0($s0)            # putchar(digit + '0')

  pop  $ra                    # Load the return address
  jr   $ra                    # Return to caller

# Find the integer remainder of the two inputs given
remainder:
  j    if_rem			      			# Branch to beginning of loop
loop_rem:
  sub  $a0, $a0, $a1 					# a = a - b
if_rem:
  slt  $t0, $a0, $a1 					# (a < b) = !(a >= b)
  beq  $t0, $zero, loop_rem 	# Branch if terminating condition
exit_rem:
  addi $v0, $a0, 0 		  			# Move 'a' into the result
  jr   $ra			        			# Return to caller

# Find the integer division quotient of the two inputs given
quotient:
  li   $v0, 0                 # Initialize loop counter
  j    if_qtnt                # Branch to beginning of loop
loop_qtnt:
  sub  $a0, $a0, $a1 		      # a = a - b
  addi $v0, $v0, 1            # count += 1
if_qtnt:
  slt  $t1, $a0, $a1 		      # (a < b) = !(a >= b)
  beq  $t1, $zero, loop_qtnt  # Branch if terminating condition
exit_qtnt:
  jr   $ra			              # Return to caller
