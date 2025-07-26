# Continuously read in a line of text until the newline character,
# then print it out in reverse
.constant HALT      0xff00
.constant TERM      0xff10
.constant KBD       0xff20
.constant STACK_TOP 0xf800
.constant NEWLINE		0x0a

nop # First instruction does not execute
main:
	li 	 $s0, TERM 									# Address of the terminal output for memory-mapped I/O
	li 	 $s1, KBD 									# Address of the keyboard input for memory-mapped I/O
	li 	 $s2, NEWLINE								# Load in newline character
	li 	 $sp, STACK_TOP							# Predefined initial stack address
read_and_reverse:
	jal  reverse_input							# Call the procedure reverse_input()
	j 	 HALT 											# Enable halt pin and stop the PC incrementing

# description: Read in text, then recursively print it in reverse
# preconditions:  $s0: the address of the terminal
#									$s1: the address of the keyboard
#									$s2: the newline character
# postconditions: the reversed string is printed to the terminal
reverse_input:
	lb 	 $t0, 0($s1)								# Load a character from the keyboard
	beq  $t0, $zero, reverse_input	# If it is the null terminator, start over
	beq  $t0, $s2, exit_rev					# If the character was the newline, stop looping
recur:
	push $ra												# Store the return address
	push $t0												# Store the current character
	jal  reverse_input							# Continue to the next character
	pop	 $t0												# Load the character
	pop	 $ra												# Load the return address
	sb 	 $t0, 0($s0)								# Print the character
exit_rev:
	jr 	 $ra												# Return to caller
