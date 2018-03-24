# frozen_string_literal: true

class Syscase
  class Example
    # OPTEE
    class OPTEE < self
      A = Syscase::Argument

      def ret
        with_size(0)
      end

      def log
        with_size(1)
      end

      def panic
        with_size(2)
      end

      def close_session
        with_size(6)
      end

      # rubocop:disable Naming/AccessorMethodName
      def get_property
        with_size(3)
      end

      def get_property_name_to_index
        with_size(4)
      end

      def get_time
        with_size(13)
      end
      # rubocop:enable Naming/AccessorMethodName

      def buf
        @buf ||= A::Alloc.new(1024)
      end

      def l
        @l ||= A::Length.new
      end

      def ref
        @ref ||= A::Ref.new(0, 7)
      end

      def prop_name
        'gpd.tee.arith.maxBigIntSize'
      end

      def with_size(number)
        { number: number, size: 8 }
      end
    end
  end
end
