# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::Ref, '#call' do
  let(:args) { [2, 3] }

  let(:expected_buffer) { %(\n\x02\x03) }
  let(:expected_extra)  { %() }

  it_should_behave_like 'argument/call'
end
