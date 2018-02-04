# frozen_string_literal: true

require 'spec_helper'

describe Syscase::SystemCallBuilder, '.new' do
  let(:subject) { described_class.new(*calls) }

  let(:calls) { [values1, values2] }

  let(:values1) { [1, 0, 3, 4] }

  let(:values2) { [2, 1, 3, 5] }

  it 'should set values' do
    expect(subject.values).to match_array(calls)
  end

  it 'should set calls to []' do
    expect(subject.calls).to eq []
  end
end
