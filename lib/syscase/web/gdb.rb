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
        functions.map do |function|
          Syscase::Web::Model::FunctionWithAddresses.new(
            function.to_h.merge(
              lines: Lines.new(
                disassemble("'#{function.file.name}'::#{function.name}")
              ).call
            )
          )
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
          @gdb_files.each_with_object([]) do |gdb_file, result|
            file, functions = gdb_file.split(":\n", 2)
            file = map_file(file)
            result.concat(map_functions(functions.split("\n"), file))
          end
        end

        def map_file(file)
          file.slice!('File ')
          Syscase::Web::Model::File.new(name: file)
        end

        def map_functions(functions, file)
          functions.map do |function|
            Syscase::Web::Model::Function.new(
              name: name_for(function),
              signature: function,
              file: file
            )
          end
        end

        def name_for(function)
          function[/.*? [*]*?([^ *]+?)\(.*\);/, 1]
        end
      end

      # Transform GDB disassemble result to array of
      # Syscase::Web::Model::LineWithAddresses
      class Lines
        LINE_REGEX = /(^[0-9]+)([^0-9]+?.*)/
        DUMP_REGEX = /Dump of assembler code for function .*?:\n(.*)/m

        def initialize(gdb_output)
          @gdb_blocks = gdb_output[DUMP_REGEX, 1]
                        .split("\nEnd of assembler dump.", 2)[0]
                        .split("\n\n")
        end

        def call
          file = nil
          @gdb_blocks.each_with_object([]) do |gdb_block, result|
            file, gdb_block = fetch_file(file, gdb_block)
            result.concat(parse_lines(gdb_block, file))
          end
        end

        private

        def fetch_file(file, gdb_block)
          line, rest, match = next_line_match(gdb_block)
          unless match
            file = Syscase::Web::Model::File.new(
              name: line[/(.*):\n/, 1]
            )
            gdb_block = rest
          end

          [file, gdb_block]
        end

        def parse_lines(block, file, lines = [])
          _, rest, match = next_line_match(block)
          return map_lines(lines, parse_addresses(block)) unless match
          parse_lines(rest, file, lines << map_line(file, match))
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
          Syscase::Web::Model::Line.new(
            file: file,
            line: number,
            code: match[2]
          )
        end

        def map_lines(lines, addresses)
          lines.map do |line|
            Syscase::Web::Model::LineWithAddresses.new(
              line.to_h.merge(addresses: addresses)
            )
          end
        end

        def parse_addresses(block, addresses = [])
          line, rest = next_line(block)
          match = /   (0x[\h]+?) <\+[0-9]+?>:([^\n]*)/.match(line)
          return addresses unless match
          parse_addresses(rest, addresses << map_address(line, match))
        end

        def map_address(_line, match)
          address = Integer(match[1])
          Syscase::Web::Model::Address.new(
            address: address,
            code: match[2]
          )
        end
      end
    end
  end
end
