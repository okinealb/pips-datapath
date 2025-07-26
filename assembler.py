import math
import re
import traceback

output_position = 0
output_buffer = []

templates = []
constants = {}

def load(contents):
  global output_position
  global output_buffer
  
  for line in contents:
    # Save the full line for comments later
    full_line = line
    
    # Remove whitespace from the line
    line = line.strip()
    
    # Break at the comment character
    parts = line.split('#', 1)
    if len(parts) > 1:
      line = parts[0]
      comment = parts[1]
    else:
      comment = None
    
    # Skip empty lines
    if len(line) == 0:
      continue
    
    # Is this a label line?
    label_match = re.match('^\s*([^\s]+):\s*$', line)
    if label_match:
      label = label_match.groups()[0]
      constants[label] = output_position
      continue
    
    # Is this a constant line?
    const_match = re.match('^\s*\.constant\s+([a-zA-Z][^\s]+)\s+([^s]+)\s*$', line)
    if const_match:
      name, value_str = const_match.groups()
      try:
        value = immediate(value_str, 16)
        constants[name] = value
      except ValueError:
        raise SyntaxError('Invalid constant value "{}"'.format(value_str))
      continue
    
    # This line must be an instruction. Find a match
    matched = False
    for pattern, instruction_count, handler in templates:
      match = re.match(pattern, line)
      if match:
        # Matched. Queue the handler to be run once all labels are collected
        output_buffer.append((instruction_count, handler, full_line, match))
        output_position += instruction_count * 4
        matched = True
        break
    
    # If no instruction rules match, raise an error
    if not matched:
      raise SyntaxError('Unrecognized line {}'.format(line))

def translate(out):
  global output_buffer
  global output_position
  
  # Write the header
  out.write('v2.0 raw\n')
  out.write('# This is an automatically-generated PIPS machine code file\n')
  
  pos = 0
  
  # Loop over output buffer entries and produce output
  for instruction_count, handler, full_line, match in output_buffer:
    try:
      out.write('\n# 0x{:04x}: {}\n'.format(pos, full_line.strip()))
      out.write(translate_line(instruction_count, handler, full_line, match))
      out.write('\n')
      pos += instruction_count * 4
    except SyntaxError as e:
      print('Error assembling line `{}`'.format(full_line.strip()))
      print('  {}'.format(e.message))
      exit(1)
    except AssemblerError as e:
      print('Invalid assembler definition while processing line `{}`'.format(full_line.strip()))
      print('  {}'.format(e.message))
      exit(2)

def translate_line(instructions, handler, line, match):
  binary = handler(*match.groups())
  
  if len(binary) != 32 * instructions:
    raise AssemblerError('Expected {} bits, but received {} instead'.format(32*instructions, len(binary)))
  
  try:
    result = ''
    for i in range(0, instructions):
      inst = binary[i*32:(i+1)*32]
      result += '{:08x} '.format(int(inst, 2))
    return result
    
  except ValueError:
    raise AssemblerError('Assembler rule produced invalid binary string "{}"'.format(binary))

# Decorator for instruction translation functions. Takes a pattern and number of instructions.
def instruction(fmt, instructions):
  def inner(handler):
    templates.append((generate_regex(fmt), instructions, handler))
    return handler
  return inner

# Generate a regular expression from an instruction syntax pattern
def generate_regex(fmt):
  # Build a regex here. Start with the beginning of the line, but allow whitespace
  regex = '^\s*'
  
  for i in range(0, len(fmt)):
    if fmt[i].isspace(): # Match whitespace
      regex += '\s*'
      
    elif fmt[i] == '#':  # Match the operand wildcard
      # Is this pattern at the end of the input?
      if i == len(fmt) - 1:
        # Yes. Match anything that isn't whitespace
        regex += '([^\s]+|\' \')'
      else:
        # No. Match anything except the following character or whitespace
        regex += '([^\s{}]+|\' \')'.format(fmt[i+1])
    
    else:
      # Match exactly the character specified in the format
      regex += re.escape(fmt[i])
  
  # Finish with whitespace and the end of the line
  regex += '\s*$'
  
  return regex

# Convert a number or number-like value to a string of bit values.
def bits(num, bits):
  result = ''
  for index in range(0, bits):
    if num & (1<<index):
      result = '1' + result
    else:
      result = '0' + result
  return result

# Convert a string in hexadecimal or decimal to its number representation with a fixed bit width
def immediate(value, bits):
  # If this is a label, use its value
  if value in constants:
    value = constants[value]
  
  # If the input is a string, convert as decimal or hex
  if isinstance(value, str):
    # Is this a character in single quotes?
    if value[0] == '\'' and value[-1] == '\'':
      # Looks like it. Decode it to process escaped characters.
      decoded = bytes(value[1:-1], 'utf-8').decode('unicode-escape')
      
      if len(decoded) != 1:
        raise SyntaxError('Unrecognized immediate value: {}'.format(value))
        
      value = ord(decoded)
      
    else:
      # Doesn't look like a character. Treat it as a string holding a number
      try:
        if value.startswith('0x'):
          # Try to convert as a hexadecimal value
          value = int(value[2:], 16)
        else:
          # Try to convert as a decimal value
          value = int(value)
      except ValueError:
        raise SyntaxError('Unrecognized immediate value: {}'.format(value))
  
  # Make sure we have an integer now
  if not isinstance(value, int):
    raise AssemblerError('immediate() expects an integer or string as input')
  
  # Make sure the value is in the representable range given the number of bits
  if value >= 2**bits or value <= -2**(bits - 1):
    raise SyntaxError('Immediate value {} does not fit in {} bits'.format(value, bits))
    
  return value  

# Raise this exception when there's something wrong with the assembler rules
class AssemblerError(Exception):
  def __init__(self, message):
    self.message = message

# Raise this exception when there's something wrong with the input to the assembler
class SyntaxError(Exception):
  def __init__(self, message):
    self.message = message
