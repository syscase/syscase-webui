# frozen_string_literal: true

class Syscase
  # System call
  class SystemCall < Syscase::ArgumentBuilder
    def initialize(config, *args)
      @config = if config.is_a?(Hash)
                  config
                else
                  { number: config }
                end
      super(padding([number] + args))
    end

    def number
      @number ||= if @config[:number].is_a?(Syscase::Argument)
                    @config[:number]
                  else
                    Syscase::Argument::SystemCallNumber.new(@config[:number])
                  end
    end

    private

    def size
      @size ||= @config.fetch(:size, 6)
    end

    def padding(args)
      n = size + 1 - args.size
      n.times { args << 0 } if n.positive?
      args
    end
  end
end
