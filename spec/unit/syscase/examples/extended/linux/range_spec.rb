# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Extended::Linux, '#range' do
  let(:subject) { object.range }

  let(:object) { described_class.new(double('input'), double('output')) }

  let(:expected) { (0..359) }

  before :each do
    allow(IO).to receive(:read) { double('file content') }
  end

  it 'should return range' do
    expect(subject).to eq expected
  end
end
