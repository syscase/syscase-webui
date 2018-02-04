# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::Vector, '#call' do
  subject { object.call(double('buffer'), double('extra')) }

  let(:object) { described_class.new }

  let(:error) { NotImplementedError }

  let(:msg) { 'Override Vector#identifier!' }

  it 'should raise NotImplementedError' do
    expect { subject }.to raise_error error, msg
  end
end
