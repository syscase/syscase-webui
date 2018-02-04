# frozen_string_literal: true

class Syscase
  # System call
  class SystemCall < Syscase::ArgumentBuilder
    attr_reader :number

    def initialize(number, *args)
      @number = if number.is_a?(Syscase::Argument::SystemCallNumber)
                  number
                else
                  Syscase::Argument::SystemCallNumber.new(number)
                end
      super(padding([@number] + args))
    end

    private

    def padding(args)
      n = 7 - args.size
      n.times { args << 0 } if n.positive?
      args
    end
  end
end
