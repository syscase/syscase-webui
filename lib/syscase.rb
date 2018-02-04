# frozen_string_literal: true

# Syscase namespace
class Syscase
  def self.ascii(string)
    string.dup.force_encoding(Encoding::ASCII)
  end

  BUFFER_DELIMITER = ascii(%(\xa5\xc9))
  CALL_DELIMITER   = ascii(%(\xb7\xe3))
end

require 'syscase/buffer'
require 'syscase/argument/number'
require 'syscase/argument/alloc'
require 'syscase/argument/string'
require 'syscase/argument/string/z'
require 'syscase/argument/string/file'
require 'syscase/argument/string/filename'
require 'syscase/argument/length'
require 'syscase/argument/file_descriptor'
require 'syscase/argument/system_call_number'
require 'syscase/argument/pid'
require 'syscase/argument/ref'
require 'syscase/argument/vector'
require 'syscase/argument/vector/v32'
require 'syscase/argument/vector/v64'
require 'syscase/argument_builder'
require 'syscase/argument'
require 'syscase/system_call'
require 'syscase/system_call_builder'
require 'syscase/example'
require 'syscase/example/linux'
require 'syscase/example/linux/example1'
require 'syscase/example/linux/example2'
require 'syscase/example/linux/example3'
require 'syscase/example/linux/example4'
require 'syscase/example/linux/example5'
require 'syscase/example/linux/example6'
require 'syscase/example/linux/example7'
require 'syscase/examples'
require 'syscase/examples/linux'
