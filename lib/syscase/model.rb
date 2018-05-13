# frozen_string_literal: true

class Syscase
  # Model base class
  class Model < Dry::Struct
    # Model that uses defaults on nil values. Dry::Struct uses defaults only
    # for missing hash values.
    class WithDefaults < self
      if respond_to? :transform_types
        nil_2_undef = ->(v) { v.nil? ? Dry::Types::Undefined : v }
        transform_types { |t| t.default? ? t.constructor(nil_2_undef) : t }
        INTEGER = Syscase::Types::Strict::Integer
      elsif respond_to? :constructor_type
        constructor_type :schema
        INTEGER = Syscase::Types::Strict::Int
      end
    end
  end
end
