# Print "Hello" to the PIPS terminal
# Charlie Curtsinger
.constant TERMINAL 0xff10
.constant HALT     0xff00

nop # First instruction does not execute
main:
  li $s0, TERMINAL
  li $t0, 0x48   # Load ASCII value for 'H'
  sb $t0, 0($s0) # Print 'H'
  li $t0, 0x65   # Load ASCII value for 'e'
  sb $t0, 0($s0) # Print 'e'
  li $t0, 0x6c   # Load ASCII value for 'l'
  sb $t0, 0($s0) # Print 'l'
  sb $t0, 0($s0) # Print 'l'
  li $t0, 0x6f   # Load ASCII value for 'o'
  sb $t0, 0($s0) # Print 'o'
  li $t0, 0x0a   # Load ASCII value for newline
  sb $t0, 0($s0) # Print newline
  j  HALT        # Stop execution