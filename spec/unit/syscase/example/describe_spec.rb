# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples, '#describe' do
  subject { object.describe }

  let(:object) { described_class.new(double('path')) }

  let(:error) { NotImplementedError }

  let(:msg) { 'Override Examples#describe!' }

  it 'should raise NotImplementedError' do
    expect { subject }.to raise_error NotImplementedError, msg
  end
end
