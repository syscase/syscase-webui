# frozen_string_literal: true

class Syscase
  # Example
  class Example < Syscase::SystemCallBuilder
    attr_reader :name, :path

    def initialize(name, path)
      @name = name
      @path = path
    end

    def compile
      parent(:initialize, *describe)

      self
    end

    def describe
      raise NotImplementedError, 'Override Examples#describe!'
    end

    def write_example
      parent(:write, File.join(path, name))
    end

    private

    def describe_of(*example_classes)
      example_classes.flat_map { |k| k.new(name, path).describe }
    end

    def parent(method, *args)
      Syscase::SystemCallBuilder
        .instance_method(method)
        .bind(self)
        .call(*args)
    end
  end
end
