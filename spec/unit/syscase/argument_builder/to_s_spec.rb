# frozen_string_literal: true

require 'spec_helper'

describe Syscase::ArgumentBuilder, '#to_s' do
  let(:subject) { object.to_s }

  let(:object) { described_class.new(*args) }

  let(:args) { [values] }
  let(:values) { [0, Syscase::Argument::Length.new, 'test'] }

  let(:expected) do
    Syscase.ascii(
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x02\xA5\xC9test\x00)
    )
  end

  it 'should build binary string' do
    expect(subject.to_s).to eql expected
  end

  context 'with custom buffer and extra' do
    let(:args) { [values, buffer, extra] }

    let(:buffer) { Syscase::Buffer.new([1, 2, 3]) }
    let(:extra) { Syscase::Buffer.new([4, 5, 6]) }

    let(:expected) do
      Syscase.ascii(
        %(123\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x02456\xA5\xC9test\x00)
      )
    end

    it 'should build binary string' do
      expect(subject.to_s).to eql expected
    end
  end
end
