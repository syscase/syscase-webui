# frozen_string_literal: true

require 'spec_helper'

describe Syscase::SystemCall, '.new' do
  before :each do
    allow(Syscase::Argument::SystemCallNumber)
      .to receive(:new) { syscall_input }
  end

  let(:syscall_input) { double('syscall') }

  let(:subject) { described_class.new(number, *values) }

  let(:number) { number_object }
  let(:number_object) { Syscase::Argument::SystemCallNumber.new(1) }

  let(:values) { [0, 2, 1] }

  let(:expected_values) { [number_object] + values + [0, 0, 0] }

  it 'should set number' do
    expect(subject.number).to eq number_object
  end

  it 'should set values with padding' do
    expect(subject.values.size).to be 7
    expect(subject.values).to match_array(expected_values)
  end

  context 'with Integer' do
    let(:number) { 1 }

    it 'should set number' do
      expect(subject.number).to eq number_object
    end

    it 'should set values with padding' do
      expect(subject.values.size).to be 7
      expect(subject.values).to match_array(expected_values)
    end
  end
end
