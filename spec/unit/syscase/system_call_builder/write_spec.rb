# frozen_string_literal: true

require 'spec_helper'

describe Syscase::SystemCallBuilder, '#to_s' do
  before :each do
    allow(IO).to receive(:write) { result }
  end

  let(:subject) { object.write(filename) }

  let(:object) { described_class.new(*calls) }

  let(:result) { double('write_result') }

  let(:filename) { double('filename') }

  let(:calls) { [values1, values2] }

  let(:values1) { [1, 0, Syscase::Argument::Length.new, 'test'] }

  let(:values2) { [2, 1, Syscase::Argument::Length.new, 'foo'] }

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
      %(\xA5\xC9test\x00) +
      # Call delimiter
      %(\xb7\xe3) +
      # SystemCallNumber 2
      %(\x00\x02) +
      # Number 1
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x01) +
      # Length 3
      %(\x03) +
      # String::Z buffer
      %(\x02) +
      # Padding Number 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # String::Z extra
      %(\xA5\xC9foo\x00)
    )
  end

  it 'should write expected string' do
    expect(IO).to receive(:write).with(filename, expected)
    expect(subject).to be result
  end
end
