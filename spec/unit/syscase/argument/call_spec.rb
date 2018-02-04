# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument, '#call' do
  subject { object.call(double('buffer'), double('extra')) }

  let(:object) { described_class.new(double('value')) }

  let(:error) { NotImplementedError }

  let(:msg) { 'Override Argument#call(buffer, extra)!' }

  it 'should raise NotImplementedError' do
    expect { subject }.to raise_error NotImplementedError, msg
  end
end
