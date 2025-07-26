# Echo characters typed to the terminal until a newline is read
# Charlie Curtsinger
.constant HALT      0xff00
.constant TERM      0xff10
.constant KBD       0xff20
.constant STACK_TOP 0xf800

nop
main:
  li   $s0, TERM       # Address of the terminal output for memory-mapped I/O
  li   $s1, KBD        # Address of the keyboard input for memory-mapped I/O
  li   $sp, STACK_TOP  # Predefined initial stack address
  
loop_top:
  lb  $t0, 0($s1)           # Load a character from the keyboard
  beq $t0, $zero, loop_top  # If it is the null terminator, start over
  sb  $t0, 0($s0)           # Write the character to the terminal
  li  $t1, '\n'             # Load a newline constant
  beq $t0, $t1, end         # If the character was the newline, stop looping
  j   loop_top              # Start over

end:
  j   HALT                  # Enable halt pin and stop the PC incrementing