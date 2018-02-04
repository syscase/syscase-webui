# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::Vector::V64, '#call' do
  let(:args) { [%(foo\n), l, %(bar\n), l] }

  let(:l) { Syscase::Argument::Length.new }

  let(:expected_buffer) { %(\x07\x04\x02\x03\x02\x03) }
  let(:expected_extra)  { %(\xa5\xc9foo\n\x00\xa5\xc9bar\n\x00) }

  it_should_behave_like 'argument/call'
end
