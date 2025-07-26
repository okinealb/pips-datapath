# Continuously read in a line of text until the newline character,
# then print it out with all lowercase letters converted to uppercase
.constant HALT      0xff00
.constant TERM      0xff10
.constant KBD       0xff20
.constant STACK_TOP 0xf800
.constant NEWLINE   0x0a

nop # First instruction does not execute
main:
	li 	 $s0, TERM 						# Address of the terminal output for memory-mapped I/O
	li 	 $s1, KBD 						# Address of the keyboard input for memory-mapped I/O
	li 	 $s2, NEWLINE					# Load in newline character
	li 	 $sp, STACK_TOP				# Predefined initial stack address
loop:
	lb 	 $t0, 0($s1)					# Load a character from the keyboard
	beq  $t0, $zero, loop			# If it is the null terminator, start over
call_upper:
	addi $a0, $t0, 0					# Move the character to the input register
	jal  upper								# Call the procedure upper(character)
  sb   $v0, 0($s0)        	# Write the output character to the terminal
	beq  $v0, $s2, end				# If the character was the newline, stop looping
	j 	 loop									# Start over
end:
	j 	 HALT 								# Enable halt pin and stop the PC incrementing

# description: Return the uppercased character if possible; otherwise the
#							 original character itself
# preconditions:  $a0: the input character
# postconditions: $v0: the uppercased/original character, based on above
upper:
  li   $t0, 'a'            	# Load in 'a' character
  li   $t1, 'z'            	# Load in 'z' character
  bgt! $t0, $a0, exit_uppr  # Branch if (char < 'a'), modifies $t0
  blt! $t1, $a0, exit_uppr  # Branch if (char > 'z'), modifies $t1
uppercase:
	subi $a0, $a0, 32 				# Uppercase the letter
exit_uppr:
	addi $v0, $a0, 0					# Move the result to output register
	jr 	 $ra									# Return to caller
