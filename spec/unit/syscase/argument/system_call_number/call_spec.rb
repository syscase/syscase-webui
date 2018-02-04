# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::SystemCallNumber, '#call' do
  let(:args) { [2] }

  let(:expected_buffer) { %(\x00\x02) }
  let(:expected_extra)  { %() }

  it_should_behave_like 'argument/call'
end
