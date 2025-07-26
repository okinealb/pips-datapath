# Print the first 15 numbers of the fibonacci sequence to the terminal
.constant TERMINAL 0xff10
.constant HALT     0xff00
.constant NEWLINE  0x0a
.constant ZERO     0x30

nop # first instruction does not execute
main: 
  li   $s0, TERMINAL          # Save the terminal address
  li   $s1, 0                 # Initialize loop counter
  li   $s2, 15                # Initialize loop end
  li   $sp, 0xf800            # Set up the stack
loop: 
  beq  $s1, $s2, exit         # Branch if reached the end of the loop
  addi $a0, $s1, 1            # Set the input to the procedure
  jal  fibonacci              # Call the procedure fibonacci(n)
  addi $a0, $v0, 0            # Put the result into the input
  jal  print_decimal_number   # Call the procedure print_decimal_number
  li   $t0, NEWLINE           # Load in newline character
  sb   $t0, 0($s0)            # Print newline

  addi $s1, $s1, 1            # Increment loop counter n += 1
  j    loop                   # Continue looping
exit: 
  j    HALT                   # Stop execution

# description: Recursively find and output the nth fibonacci number
# preconditions:  $a0: a non-negative integer
# postconditions: $v0: the nth fibonacci number
fibonacci:
  slti $t0, $a0, 2            # Check if n < 2
  beq  $t0, $zero, recur      # Branch if not (recursive case)

  addi $v0, $a0, 0            # Move input to return register
  jr   $ra                    # Return to caller
recur:
  push $ra                    # Store the return address
  push $a0                    # Store the input

  addi $a0, $a0, -1           # Set the input (n-1)
  jal  fibonacci              # Call the procedure fibonacci(n-1)
  pop  $a0                    # Load the input n
  push $v0                    # Store the result
  addi $a0, $a0, -2           # Set the input (n-2)
  jal  fibonacci              # Call the procedure fibonacci(n-2)

  pop  $t0                    # Load the previous result
  add  $v0, $t0, $v0          # fibonacci(n-1) + fibonacci(n-2)
  pop  $ra                    # Load the return address  
  jr   $ra                    # Return to caller

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
# if-inner (this is for mental mapping)
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
# Precondition:  $a0-$a1: non-zero numbers
# Postcondition: $v0: the remainder of $a0 and $a1
remainder:
  j    if_rem			            # Branch to beginning of loop
loop_rem:
  sub  $a0, $a0, $a1 		      # a = a - b
if_rem:
  slt  $t0, $a0, $a1 		      # (a < b) = !(a >= b)
  beq  $t0, $zero, loop_rem   # Branch if terminating condition
exit_rem:
  addi $v0, $a0, 0 		        # Move 'a' into the result
  jr   $ra			              # Return to caller

# Find the integer division quotient of the two inputs given
# Precondition:  $a0-$a1: non-zero number
# Postcondition: $v0: the quotient of $a0 and $a1
quotient:
  addi $t0, $zero, 0          # Initialize loop counter
  j    if_qtnt                # Branch to beginning of loop
loop_qtnt:
  sub  $a0, $a0, $a1 		      # a = a - b
  addi $t0, $t0, 1            # count += 1
if_qtnt:
  slt  $t1, $a0, $a1 		      # (a < b) = !(a >= b)
  beq  $t1, $zero, loop_qtnt  # Branch if terminating condition
exit_qtnt:
  addi $v0, $t0, 0 		        # Move 'count' into the result
  jr   $ra			              # Return to caller
