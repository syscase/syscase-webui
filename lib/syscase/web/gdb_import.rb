# frozen_string_literal: true

class Syscase
  class Web
    # Import of GDB disassembling result to database
    class GDBImport
      def initialize(gdb_args = [])
        @gdb = Syscase::Web::GDB.new(*gdb_args)
      end

      def call
        functions.transaction do |_transaction|
          @gdb.disassembled_functions.each do |function|
            create_function(function)
          end
        end

        self
      end

      private

      def create_function(function)
        hash = function.to_h
        create_lines(functions.create(create_file_for(hash))[:id],
                     function.lines)

        self
      end

      def create_file_for(function_hash)
        function_hash[:file] = file_id_for(function_hash[:file])

        function_hash
      end

      def file_id_for(file)
        files.by_name(file[:name])[:id]
      rescue ROM::TupleCountMismatchError
        create_file(file)[:id]
      end

      def create_file(file)
        files.create(file.to_h)
      end

      def create_lines(function_id, lines)
        lines.each do |line|
          hash = line.to_h
          hash[:function] = function_id
          hash[:file] = file_id_for(hash[:file])

          create_addresses(create_line(hash)[:id], line.addresses)
        end
      end

      def create_line(line)
        lines.create(line.to_h)
      end

      def create_addresses(line_id, addresses)
        addresses.each do |address|
          hash = address.to_h
          hash[:line] = line_id

          create_address(hash)
        end

        self
      end

      def create_address(address)
        addresses.create(address.to_h)
      end

      REPO = Syscase::Web::Persistence::Repositories

      def files
        @files ||= Syscase::Web.db.repository(REPO::Files)
      end

      def lines
        @lines ||= Syscase::Web.db.repository(REPO::Lines)
      end

      def functions
        @functions ||= Syscase::Web.db.repository(REPO::Functions)
      end

      def addresses
        @addresses ||= Syscase::Web.db.repository(REPO::Addresses)
      end
    end
  end
end
