# frozen_string_literal: true

class Syscase
  # Examples
  class Examples
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def describe
      raise NotImplementedError, 'Override Examples#describe!'
    end

    def describe_of(namespace, n, name_prefix = 'ex', class_prefix = 'Example')
      hash = {}
      n.times do |i|
        hash.merge!(hash_for(i + 1, namespace, name_prefix, class_prefix))
      end

      hash
    end

    def examples
      describe.map do |key, value|
        example_for(key, value)
      end.to_h
    end

    def compile
      hash = examples
      hash.each_value(&:compile)
      hash
    end

    def write
      compile.transform_values(&:write_example)
    end

    private

    def sym_for(name_prefix, n)
      "#{name_prefix}#{n}".to_sym
    end

    def class_for(namespace, class_prefix, n)
      namespace.const_get("#{class_prefix}#{n}")
    end

    def hash_for(n, namespace, name_prefix, class_prefix)
      klass = class_for(namespace, class_prefix, n)
      {
        sym_for(name_prefix, n) => klass
      }
    end

    def example_for(key, value)
      [key, value.new(key.to_s, path)]
    end
  end
end
