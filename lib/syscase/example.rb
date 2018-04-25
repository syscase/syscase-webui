# frozen_string_literal: true

class Syscase
  # Example
  class Example < Syscase::SystemCallBuilder
    attr_reader :name, :path

    MODES = {
      1 => 'linux',
      2 => 'optee',
      4 => 'opteesmc'
    }.freeze

    def initialize(name, path)
      @name = name
      @path = path
    end

    def compile
      return self unless @values.nil?
      with(describe)
    end

    def with(args)
      parent(:initialize, *args)

      self
    end

    def describe
      raise NotImplementedError, 'Override Examples#describe!'
    end

    def write_example
      parent(:write, File.join(path, name))
    end

    def name_with_mode
      [MODES[fuzzing_mode], name].join('_')
    end

    def fuzzing_mode
      case self
      when Syscase::Example::Linux
        1
      when Syscase::Example::OPTEE
        2
      when Syscase::Example::OPTEESMC
        4
      else
        raise_fuzzing_mode_error
      end
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

    def raise_fuzzing_mode_error
      raise ArgumentError, 'Can not get fuzzing mode for example class '\
        "#{@example.class}. Your example should extend "\
        'Syscase::Example::Linux, '\
        'Syscase::Example::OPTEE, '\
        'Syscase::Example::OPTEESMC or one of its child classes!'
    end
  end
end
