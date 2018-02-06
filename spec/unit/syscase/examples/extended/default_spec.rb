# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Extended, '#default' do
  let(:subject) { object.default }

  let(:object) { described_class.new(double('input'), double('output')) }

  before :each do
    allow(IO).to receive(:read) { double('file content') }
  end

  let(:error) { NotImplementedError }

  let(:msg) { 'Override Extended#example_default!' }

  it 'should raise NotImplementedError' do
    expect { subject }.to raise_error NotImplementedError, msg
  end
end
