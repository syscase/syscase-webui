# frozen_string_literal: true

require 'spec_helper'

describe Syscase::ArgumentBuilder, '.new' do
  let(:args) { [0, Syscase::Argument::Length.new, 'test'] }

  let(:subject) { described_class.new(args) }

  it 'should set values' do
    expect(subject.values).to eql args
  end

  context 'with invalid size' do
    let(:args) { [0, Syscase::Argument::Length, 'test'] }

    let(:error) { Syscase::ArgumentBuilder::UnsupportedTypeError }

    let(:msg) do
      "Type 'Class' of value 'Syscase::Argument::Length' not supported!"
    end

    it 'should raise SizeError' do
      expect { subject.to_s }.to raise_error(error, msg)
    end
  end
end
