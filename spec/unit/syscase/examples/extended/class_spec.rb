# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Extended, '#example_class' do
  let(:subject) { object.example_class }

  let(:object) { described_class.new(double('input'), double('output')) }

  before :each do
    allow(IO).to receive(:read) { double('file content') }
  end

  let(:error) { NotImplementedError }

  let(:msg) { 'Override Extended#example_class!' }

  it 'should raise NotImplementedError' do
    expect { subject }.to raise_error NotImplementedError, msg
  end
end
