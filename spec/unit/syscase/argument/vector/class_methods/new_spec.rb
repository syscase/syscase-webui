# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::Vector, '.new' do
  let(:args) do
    a = []
    255.times { a << rand(10) }
    a
  end

  let(:subject) { described_class.new(*args) }

  it 'should set values' do
    expect(subject.values).to eql args
  end

  context 'with invalid size' do
    let(:args) do
      a = []
      256.times { a << rand(10) }
      a
    end

    let(:error) { Syscase::Argument::Vector::SizeError }

    let(:msg) { 'Size (256) of vector has to be smaller than 256!' }

    it 'should raise SizeError' do
      expect { subject }.to raise_error error, msg
    end
  end
end
