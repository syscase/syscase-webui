# frozen_string_literal: true

class Syscase
  # Combined examples
  class Combined
    def initialize(dir, *example_sets)
      @dir = dir
      @example_sets = example_sets
    end

    def examples
      @example_sets.map do |example_set|
        example_set.compile.values
      end.flatten
    end

    def sliced_examples
      examples.shuffle.each_slice(3)
    end

    def cases
      sliced_examples.map do |slice|
        {
          name: File.join(@dir, slice.map(&:name_with_mode).join('_')),
          case: Syscase::CaseBuilder.new(*slice)
        }
      end
    end

    def write
      cases.each do |hash|
        hash[:case].write(hash[:name])
      end
    end
  end
end
