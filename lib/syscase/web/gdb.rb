# frozen_string_literal: true

class Syscase
  class Web
    # Run GDB
    class GDB
      ROOT = File.dirname(Syscase::Web.root)
      CMD = 'gdb'
      CMD_PREFIX = File.join(ROOT, 'toolchains/aarch64/bin/aarch64-linux-gnu-')
      BINARY = File.join(ROOT, 'optee_os/out/arm/core/tee.elf')

      def initialize(cmd_prefix = CMD_PREFIX, binary = BINARY)
        @args = [
          "#{cmd_prefix}#{CMD}",
          '-batch',
          '-ex',
          "file #{binary}", '-ex'
        ]
      end

      def run(cmd)
        IO.popen(@args + [cmd]).read
      end

      def functions
        Functions.new(run('info functions')).call
      end

      def disassemble(function)
        run("disassemble /s #{function}")
      end

      def disassembled_functions
        functions.transform_values do |functions|
          functions.map do |function|
            function.merge(
              lines: Lines.new(
                disassemble("'#{function[:file]}'::#{function[:name]}")
              ).call
            )
          end
        end
      end

      # Transform GDB info functions result to hash
      class Functions
        def initialize(gdb_output)
          gdb_output.slice!("All defined functions:\n\n")
          @gdb_files = gdb_output
                       .split("\nNon-debugging symbols:\n", 2)[0]
                       .split("\n\n")
        end

        def call
          @gdb_files.each_with_object({}) do |gdb_file, hash|
            file, functions = gdb_file.split(":\n", 2)
            file = map_file(file)
            hash[file] = map_functions(functions.split("\n"), file)
          end
        end

        def map_file(file)
          file.slice!('File ')
          file
        end

        def map_functions(functions, file)
          functions.map do |function|
            {
              name: name_for(function),
              signature: function,
              file: file
            }
          end
        end

        def name_for(function)
          function[/.*? [*]*?([^ *]+?)\(.*\);/, 1]
        end
      end

      # Transform GDB disassemble result to hash
      class Lines
        LINE_REGEX = /(^[0-9]+)([^0-9]+?.*)/

        def initialize(gdb_output)
          gdb_output.slice!(
            "Dump of assembler code for function cpu_spin_lock_dldetect:\n"
          )
          @gdb_blocks = gdb_output
                        .split("\nEnd of assembler dump.", 2)[0]
                        .split("\n\n")
        end

        def call
          file = nil
          @gdb_blocks.each_with_object({}) do |gdb_block, hash|
            line, rest, match = next_line_match(gdb_block)
            unless match
              file = line[/(.*):\n/, 1]
              gdb_block = rest
            end
            hash.merge!(parse_lines(gdb_block, file))
          end
        end

        private

        def parse_lines(block, file, lines = {})
          _, rest, match = next_line_match(block)
          return map_lines(lines, parse_addresses(block)) unless match
          parse_lines(rest, file, lines.merge(map_line(file, match)))
        end

        def next_line(block)
          block_lines = block.lines
          [block_lines[0], block_lines[1..-1].to_a.join]
        end

        def next_line_match(block)
          line, rest = next_line(block)
          [line, rest, LINE_REGEX.match(line)]
        end

        def map_line(file, match)
          number = Integer(match[1])
          {
            number => { file: file, line: number, code: match[2] }
          }
        end

        def map_lines(lines, addresses)
          lines.transform_values do |line|
            line.merge(addresses: addresses)
          end
        end

        def parse_addresses(block, addresses = {})
          line, rest = next_line(block)
          match = /   (0x[\h]+?) <\+[0-9]+?>:([^\n]*)/.match(line)
          return addresses unless match
          parse_addresses(rest, addresses.merge(map_address(line, match)))
        end

        def map_address(_line, match)
          address = Integer(match[1])
          {
            address => { address: address, code: match[2] }
          }
        end
      end
    end
  end
end
