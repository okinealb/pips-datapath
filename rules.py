import assembler
import pips

# The instruction decorator tells the assembler to create a new syntax rule for add instructions.
# The "#" spots indicate operands, which are passed in as parameters to the function below.
# The second parameter indicates the number of instructions this rule will create (1 in this case)
@assembler.instruction('add #, #, #', 1)
def add_instr(dest, operand1, operand2):
  return pips.rformat(opcode='add', r0=dest, r1=operand1, r2=operand2)

# Encode an addi instruction
@assembler.instruction('addi #, #, #', 1)
def addi_instr(dest, op1, immediate):
  return pips.iformat(opcode='add', r0=dest, r1=op1, imm=immediate)
  
# Encode the li pseudoinstruction using an addition to zero
@assembler.instruction('li #, #', 1)
def li_instr(dest, immediate):
  return addi_instr(dest, '$zero', immediate)

# Encode a sub instruction
@assembler.instruction('sub #, #, #', 1)
def add_instr(dest, operand1, operand2):
  return pips.rformat(opcode='sub', r0=dest, r1=operand1, r2=operand2)

# Encode a subi instruction
@assembler.instruction('subi #, #, #', 1)
def subi_instr(dest, op1, immediate):
  return pips.iformat(opcode='sub', r0=dest, r1=op1, imm=immediate)

# Encode a nop instruction using an addition with zero
@assembler.instruction('nop', 1)
def nop_instr():
  return add_instr('$zero', '$zero', '$zero')

# Encode a and instruction
@assembler.instruction('and #, #, #', 1)
def and_instr(dest, operand1, operand2):
  return pips.rformat(opcode='and', r0=dest, r1=operand1, r2=operand2)

# Encode a andi instruction
@assembler.instruction('andi #, #, #', 1)
def andi_instr(dest, op1, immediate):
  return pips.iformat(opcode='and', r0=dest, r1=op1, imm=immediate)

# Encode a or instruction
@assembler.instruction('or #, #, #', 1)
def or_instr(dest, operand1, operand2):
  return pips.rformat(opcode='or', r0=dest, r1=operand1, r2=operand2)

# Encode a ori instruction
@assembler.instruction('ori #, #, #', 1)
def ori_instr(dest, op1, immediate):
  return pips.iformat(opcode='or', r0=dest, r1=op1, imm=immediate)

# Encode a nand instruction
@assembler.instruction('nand #, #, #', 1)
def nand_instr(dest, operand1, operand2):
  return pips.rformat(opcode='nand', r0=dest, r1=operand1, r2=operand2)

# Encode a nandi instruction
@assembler.instruction('nandi #, #, #', 1)
def nandi_instr(dest, op1, immediate):
  return pips.iformat(opcode='nand', r0=dest, r1=op1, imm=immediate)

# Encode a nor instruction
@assembler.instruction('nor #, #, #', 1)
def nor_instr(dest, operand1, operand2):
  return pips.rformat(opcode='nor', r0=dest, r1=operand1, r2=operand2)

# Encode a nori instruction
@assembler.instruction('nori #, #, #', 1)
def nori_instr(dest, op1, immediate):
  return pips.iformat(opcode='nor', r0=dest, r1=op1, imm=immediate)

# Encode a xor instruction
@assembler.instruction('xor #, #, #', 1)
def xor_instr(dest, operand1, operand2):
  return pips.rformat(opcode='xor', r0=dest, r1=operand1, r2=operand2)

# Encode a xori instruction
@assembler.instruction('xori #, #, #', 1)
def xori_instr(dest, op1, immediate):
  return pips.iformat(opcode='xor', r0=dest, r1=op1, imm=immediate)

# Encode a slt instruction
@assembler.instruction('slt #, #, #', 1)
def slt_instr(dest, operand1, operand2):
  return pips.rformat(opcode='slt', r0=dest, r1=operand1, r2=operand2)

# Encode a slti instruction
@assembler.instruction('slti #, #, #', 1)
def slti_instr(dest, op1, immediate):
  return pips.iformat(opcode='slt', r0=dest, r1=op1, imm=immediate)

# Encode a sltu instruction
@assembler.instruction('sltu #, #, #', 1)
def sltu_instr(dest, operand1, operand2):
  return pips.rformat(opcode='sltu', r0=dest, r1=operand1, r2=operand2)

# Encode a sltiu instruction
@assembler.instruction('sltiu #, #, #', 1)
def sltiu_instr(dest, op1, immediate):
  return pips.iformat(opcode='sltu', r0=dest, r1=op1, imm=immediate)

# Encode a j instruction
@assembler.instruction('j #', 1)
def j_instr(jumpAddr):
  return pips.iformat(opcode='j', r0='$zero', r1='$zero', imm=jumpAddr,
    link=False)

# Encode a jr instruction
@assembler.instruction('jr #', 1)
def jr_instr(jumpReg):
  return pips.rformat(opcode='j', r0='$zero', r1='$zero', r2=jumpReg,
    link=False)

# Encode a jal instruction
@assembler.instruction('jal #', 1)
def jal_instr(jumpAddr):
  return pips.iformat(opcode='j', r0='$ra', r1='$zero', imm=jumpAddr,
    link=True)

# Encode a beq instruction
@assembler.instruction('beq #, #, #', 1)
def beq_instr(op1, op2, branchAddr):
  return pips.iformat(opcode='beq', r0=op1, r1=op2, imm=branchAddr)

# Encode a bne instruction
@assembler.instruction('bne #, #, #', 1)
def bne_instr(op1, op2, branchAddr):
  return pips.iformat(opcode='bne', r0=op1, r1=op2, imm=branchAddr)

# Encode a lb instruction
@assembler.instruction('lb #, #(#)', 1)
def lb_instr(dest, offsetImm, baseReg):
  return pips.iformat(opcode='lb', r0=dest, r1=baseReg, imm=offsetImm)

# Encode a lw instruction
@assembler.instruction('lw #, #(#)', 1)
def lw_instr(dest, offsetImm, baseReg):
  return pips.iformat(opcode='lw', r0=dest, r1=baseReg, imm=offsetImm)

# Encode a sb instruction
@assembler.instruction('sb #, #(#)', 1)
def sb_instr(src, offsetImm, baseReg):
  return pips.iformat(opcode='sb', r0=src, r1=baseReg, imm=offsetImm)

# Encode a sw instruction
@assembler.instruction('sw #, #(#)', 1)
def sw_instr(src, offsetImm, baseReg):
  return pips.iformat(opcode='sw', r0=src, r1=baseReg, imm=offsetImm)

# Encode a sll instruction
@assembler.instruction('sll #, #, #', 1)
def sll_instr(dest, src, shiftAmt):
  return pips.rformat(opcode= 'add', r0=dest, r1='$zero', r2=src,
		shift_type=pips.SHIFT_LEFT, shift_amt=shiftAmt)

# Encode a srl instruction
@assembler.instruction('srl #, #, #', 1)
def srl_instr(dest, src, shiftAmt):
  return pips.rformat(opcode= 'add', r0=dest, r1='$zero', r2=src,
		shift_type=pips.SHIFT_RIGHT_LOGICAL, shift_amt=shiftAmt)

# Encode a sra instruction
@assembler.instruction('sra #, #, #', 1)
def sra_instr(dest, src, shiftAmt):
  return pips.rformat(opcode= 'add', r0=dest, r1='$zero', r2=src,
		shift_type=pips.SHIFT_RIGHT_ARITHMETIC, shift_amt=shiftAmt)

# Encode a not instruction
@assembler.instruction('not #, #', 1)
def not_instr(dest, src):
  return nor_instr(dest, src, src)

# Encode a push instruction
@assembler.instruction('push #', 2) 
def push_instr(reg):
  return subi_instr('$sp', '$sp', '2') + sw_instr(reg, '0', '$sp')

# Encode a pop instruction
@assembler.instruction('pop #', 2) 
def pop_instr(reg):
  return lw_instr(reg, '0', '$sp') + addi_instr('$sp', '$sp', '2')

# Encode a blt! instruction
@assembler.instruction('blt! #, #, #', 2) 
def blt_instr(op1, op2, branchAddr):
  return slt_instr(op1, op1, op2) + bne_instr(op1, '$zero', branchAddr)

# Encode a ble! instruction
@assembler.instruction('ble! #, #, #', 2) 
def ble_instr(op1, op2, branchAddr):
  return slt_instr(op1, op2, op1) + beq_instr(op1, '$zero', branchAddr)

# Encode a bgt! instruction
@assembler.instruction('bgt! #, #, #', 2) 
def bgt_instr(op1, op2, branchAddr):
  return slt_instr(op1, op2, op1) + bne_instr(op1, '$zero', branchAddr)

# Encode a bge! instruction
@assembler.instruction('bge! #, #, #', 2) 
def bge_instr(op1, op2, branchAddr):
  return slt_instr(op1, op1, op2) + beq_instr(op1, '$zero', branchAddr)
