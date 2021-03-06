# frozen_string_literal: true

require 'dry-struct'

# Syscase namespace
class Syscase
  def self.ascii(string)
    string.dup.force_encoding(Encoding::ASCII)
  end

  # Get root path
  #
  # @return [dir_name]
  #
  # @api private
  #
  def self.root
    File.dirname(File.dirname(File.expand_path(__FILE__)))
  end

  BUFFER_DELIMITER = ascii(%(\xa5\xc9))
  CALL_DELIMITER   = ascii(%(\xb7\xe3))
  CASE_DELIMITER   = ascii(%(\xe3\xb7))
end

require 'syscase/buffer'
require 'syscase/types'
require 'syscase/model'
require 'syscase/model/optee/smc/msg'
require 'syscase/model/optee/time'
require 'syscase/model/optee/uuid'
require 'syscase/model/optee/utee_params'
require 'syscase/model/optee/utee_attribute'
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
require 'syscase/argument/optee/smc/msg'
require 'syscase/argument/optee/time'
require 'syscase/argument/optee/uuid'
require 'syscase/argument/optee/utee_params'
require 'syscase/argument/optee/utee_attribute'
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
require 'syscase/example/optee'
require 'syscase/example/optee/example1'
require 'syscase/example/optee/example2'
require 'syscase/example/optee/example3'
require 'syscase/example/optee/example4'
require 'syscase/example/optee/example5'
require 'syscase/example/optee/example6'
require 'syscase/example/optee/example7'
require 'syscase/example/optee/example8'
require 'syscase/example/optee/example9'
require 'syscase/example/optee/example10'
require 'syscase/example/optee/example11'
require 'syscase/example/optee_smc'
require 'syscase/example/optee_smc/example1'
require 'syscase/example/optee_smc/example2'
require 'syscase/example/optee_smc/example3'
require 'syscase/example/optee_smc/example4'
require 'syscase/example/optee_smc/example5'
require 'syscase/example/optee_smc/example6'
require 'syscase/example/optee_smc/example7'
require 'syscase/example/optee_smc/example8'
require 'syscase/example/optee_smc/example9'
require 'syscase/example/optee_smc/example10'
require 'syscase/example/optee_smc/example11'
require 'syscase/example/optee_smc/example12'
require 'syscase/example/optee_smc/example13'
require 'syscase/example/optee_smc/example14'
require 'syscase/example/optee_smc/example15'
require 'syscase/example/optee_smc/example16'
require 'syscase/example/optee_smc/example17'
require 'syscase/example/optee_smc/example18'
require 'syscase/example/optee_smc/example19'
require 'syscase/example/optee_smc/example20'
require 'syscase/example/optee_smc/example21'
require 'syscase/example/optee_smc/example22'
require 'syscase/example/optee_smc/example23'
require 'syscase/example/optee_smc/example24'
require 'syscase/examples'
require 'syscase/examples/linux'
require 'syscase/examples/optee'
require 'syscase/examples/optee_smc'
require 'syscase/examples/extended'
require 'syscase/examples/extended/linux'
require 'syscase/case'
require 'syscase/case_builder'
require 'syscase/combined'
require 'syscase/web'
