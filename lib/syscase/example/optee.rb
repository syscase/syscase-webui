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

      def open_session
        with_size(5)
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

      def set_ta_time
        with_size(14)
      end
      # rubocop:enable Naming/AccessorMethodName

      def asymm_operate
        39
      end

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

      def optee_time_arg
        A::OPTEE::Time.new(
          Syscase::Model::OPTEE::Time.new(
            seconds: 12_345,
            millis: 4567
          )
        )
      end

      def optee_uuid_arg
        A::OPTEE::UUID.new(
          Syscase::Model::OPTEE::UUID.new(
            time_low: 1_234,
            time_mid: 5_678,
            time_hi_and_version: 90
          )
        )
      end

      def utee_params_arg
        A::OPTEE::UTEEParams.new(
          Syscase::Model::OPTEE::UTEEParams.new(
            types: 1
          )
        )
      end

      def utee_attribute_arg
        A::OPTEE::UTEEAttribute.new(
          Syscase::Model::OPTEE::UTEEAttribute.new(
            a: 1,
            b: 2,
            id: 123
          )
        )
      end
    end
  end
end
