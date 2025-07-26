import assembler

############################
### PIPS Assembler Rules ###
############################

# This architecture uses 16-bit words, meaning all registers and addresses are 16-bit values.
# There are 16 unique opcodes, although these can be used to encode many more than 16
# unique instructions. Each instruction is encoded as a 32-bit value.

# Immediate Format
#   | opcode | r0    | r1    | unused | link | 1 | immediate |
#     31-28    27-24   23-20   19-18    17     16  15-0
# See the encoding function below for a description of each field

# Generate an instruction encoding in immediate format.
# Each parameter is encoded as a field in the output. Utility functions and tables below show how
# this encoding works. This function simply combines the parts of an instruction into a 4-byte
# machine instruction.
#
# @param opcode What operation should this instruction perform? Pass in the string mnemonic.
#
# @param r0     Often the destination register, although beq and bne use this as an input. Pass
#               in a string name of the register.
#
# @param r1     An operand to the instruction. Pass in a register name as a string
#
# @param imm    The immediate value usually used as an input operand, although beq and bne use
#               this as the destination address. Pass in an integer value.
# @param link   If set, use the value of PC+4 instead of the ALU output. This is useful for
#               updating $ra during the execution of a jal instruction. Pass True or False.
def iformat(opcode, r0, r1, imm, link=False):
  return assembler.bits(encode_op(opcode), 4) + \
         assembler.bits(encode_reg(r0), 4) + \
         assembler.bits(encode_reg(r1), 4) + \
         '00' + assembler.bits(link, 1) + '1' + \
         assembler.bits(assembler.immediate(imm, 16), 16)

# Constants for shift types
SHIFT_NONE = 0
SHIFT_LEFT = 1
SHIFT_RIGHT_LOGICAL = 2
SHIFT_RIGHT_ARITHMETIC = 3

# Register Format
#   | opcode | r0    | r1    | unused | link | 0 | r2    | shift type | unused | shift amt. |
#     31-28    27-24   23-20   19-18    17     16  15-12   11-10        9-4      3-0
# See the encoding function below for a description of each field

# Generate an instruction encoding in register format
# Each parameter is encoded as a field in the output. Utility functions and tables below show how
# this encoding works. This function simply combines the parts of an instruction into a 4-byte
# machine instruction.
#
# @param opcode What operation should this instruction perform? Pass in the string mnemonic.
#
# @param r0     Often the destination register, although beq and bne use this as an input. Pass
#               in a string name of the register.
#
# @param r1     An operand to the instruction. Pass in a register name as a string
#
# @param r2     This register is usually used as the second input operand, although beq and bne
#               will use it as the destination address. Pass a register name as a string.
#
# @param link   If set, use the value of PC+4 instead of the ALU output. This is useful for
#               updating $ra during the execution of a jal instruction. Pass True or False.
#
# @param shift type  Indicates how the value in r2 should be shifted. Pass in 0 (left shift), 1
#                    (right shift), or 2 (right arithmetic shift).
#
# @param shift amt.  How many bits should the value in r2 be shifted? Pass in an integer value
#                    between 0 and 31 (inclusive).
def rformat(opcode, r0, r1, r2, link=False, shift_type=SHIFT_NONE, shift_amt=0):
  return assembler.bits(encode_op(opcode), 4) + \
         assembler.bits(encode_reg(r0), 4) + \
         assembler.bits(encode_reg(r1), 4) + \
         '00' + assembler.bits(link, 1) + '0' + \
         assembler.bits(encode_reg(r2), 4) + \
         assembler.bits(shift_type, 2) + '00' + \
         '0000' + \
         assembler.bits(assembler.immediate(shift_amt, 4), 4)
         

# The opcode field is encoded as follows:
opcode_table = {
  'add':  0,  # Add two values
  'sub':  1,  # Subtract two values
  'and':  2,  # Compute the bitwise AND of two values
  'or':   3,  # Compute the bitwise OR of two values
  'nand': 4,  # Compute the bitwise NAND of two values
  'nor':  5,  # Compute the bitwise NOR of two values
  'xor':  6,  # Compute the bitwise XOR of two values
  'slt':  7,  # Compare two signed values
  'sltu': 8,  # Compare two unsigned values
  'lb':   9,  # Load a 8-bit value from memory
  'lw':   10, # Load a 16-bit value from memory
  'sb':   11, # Store an 8-bit value to memory
  'sw':   12, # Store a 16-bit value to memory
  'beq':  13, # Branch to a destination if two registers are equal
  'bne':  14, # Branch to a destination if two registers are different
  'j':    15  # Jump unconditionally to a destination
}

# Utility function to convert an opcode to its index
def encode_op(name):
  if name not in opcode_table:
    raise assembler.SyntaxError('Invalid opcode name: {}'.format(name))
  return opcode_table[name]

# Registers are encoded as follows:
register_table = {
  '$zero': 0,
  '$v0': 1,
  '$a0': 2,
  '$a1': 3,
  '$a2': 4,
  '$a3': 5,
  '$t0': 6,
  '$t1': 7,
  '$t2': 8,
  '$t3': 9,
  '$s0': 10,
  '$s1': 11,
  '$s2': 12,
  '$s3': 13,
  '$sp': 14,
  '$ra': 15
}

# Utility function to convert a register name to its index
def encode_reg(name):
  if name not in register_table:
    raise assembler.SyntaxError('Invalid register name: {}'.format(name))
  return register_table[name]
