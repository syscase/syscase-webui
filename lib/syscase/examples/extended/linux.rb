# frozen_string_literal: true

class Syscase
  class Examples
    class Extended
      # Extended Linux Examples
      class Linux < self
        private

        A = Syscase::Argument

        def example_map
          {
            buffer: [default],
            fd: [A::FileDescriptor.new(1), A::String::File.new('testing')],
            filename: [A::String::Filename.new('testing')],
            int: [0],
            ptr: [default],
            signalno: [0],
            string: ['12345678'],
            len: [A::Length.new]
          }.freeze
        end

        def example_default
          A::Alloc.new(8)
        end

        def example_class
          Syscase::Example::Linux
        end

        def example_range
          (0..359)
        end
      end
    end
  end
end
