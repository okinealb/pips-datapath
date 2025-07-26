# Print "Hello World!" to the PIPS terminal
# Charlie Curtsinger
.constant HALT 0xff00
.constant TERM 0xff10

nop
main:
  li $s0, TERM
  li $t0, 'H'
  sb $t0, 0($s0)
  li $t0, 'e'
  sb $t0, 0($s0)
  li $t0, 'l'
  sb $t0, 0($s0)
  sb $t0, 0($s0)
  li $t0, 'o'
  sb $t0, 0($s0)
  li $t0, ' '
  sb $t0, 0($s0)
  li $t0, 'W'
  sb $t0, 0($s0)
  li $t0, 'o'
  sb $t0, 0($s0)
  li $t0, 'r'
  sb $t0, 0($s0)
  li $t0, 'l'
  sb $t0, 0($s0)
  li $t0, 'd'
  sb $t0, 0($s0)
  li $t0, '!'
  sb $t0, 0($s0)
  j  HALT