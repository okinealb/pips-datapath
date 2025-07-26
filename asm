#!/usr/bin/env python3
import argparse
import os
import re
import sys
import traceback

import assembler
import rules

# Wrap the ArgumentParser class to display usage on empty input
# Source: https://groups.google.com/forum/#!topic/argparse-users/LazV_tEQvQw
class MyParser(argparse.ArgumentParser):
  def error(self, message):
    sys.stderr.write('error: {}\n\n'.format(message))
    self.print_help()
    sys.exit(2)

if __name__ == '__main__':
  # Set up argument parser
  parser = MyParser(description='PIPS Assembler')
  parser.add_argument('-o', '--output', help='Output file (default is <input filename>.hex)', type=argparse.FileType('w'))
  parser.add_argument('inputs', nargs='+', type=argparse.FileType('r'), help='One or more input assembly files')
  
  # Run argument parser
  args = parser.parse_args()
  
  # If the output file wasn't specified, open one
  if not args.output:
    input_parts = args.inputs[0].name.rsplit('.', 1)
    output_filename = input_parts[0] + '.hex'
    try:
      args.output = open(output_filename, 'w')
    except Exception as e:
      print(e)
      parser.error('Unable to open output file {} for writing'.format(output_filename))
      parser.print_help()
      exit(2)
  
  # Load each input file into the assembler
  for f in args.inputs:
    assembler.load(f)
  
  # Translate the output
  assembler.translate(args.output)
  
  # Close the output file
  args.output.close()

#test('addi $ra, $t1, 123')
#test('li $t0, 0xCA72')
#test('push $t1')
#test('pop $t1')
