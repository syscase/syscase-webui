# frozen_string_literal: true

require 'spec_helper'

describe Syscase::SystemCall, '#to_s' do
  let(:subject) { object.to_s }

  let(:object) { described_class.new(number, *values) }

  let(:number) { number_object }

  let(:number_object) { Syscase::Argument::SystemCallNumber.new(1) }

  let(:values) { [0, Syscase::Argument::Length.new, 'test'] }

  let(:expected) do
    Syscase.ascii(
      # SystemCallNumber 1
      %(\x00\x01) +
      # Number 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # Length 3
      %(\x03) +
      # String::Z buffer
      %(\x02) +
      # Padding Number 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # String::Z extra
      %(\xA5\xC9test\x00)
    )
  end

  it 'should build binary string' do
    expect(subject.to_s).to eql expected
  end
end
