# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::Pid, '#call' do
  let(:args) { [2] }

  let(:expected_buffer) { %(\t\x02) }
  let(:expected_extra)  { %() }

  it_should_behave_like 'argument/call'
end
