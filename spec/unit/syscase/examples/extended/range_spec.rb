# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Extended, '#range' do
  let(:subject) { object.range }

  let(:object) { described_class.new(double('input'), double('output')) }

  before :each do
    allow(IO).to receive(:read) { double('file content') }
  end

  let(:error) { NotImplementedError }

  let(:msg) { 'Override Extended#example_range!' }

  it 'should raise NotImplementedError' do
    expect { subject }.to raise_error NotImplementedError, msg
  end
end
