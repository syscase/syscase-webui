# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::String::File, '#call' do
  let(:args) { [value] }

  let(:value) { 'Hello World' }

  let(:expected_buffer) { %(\x04) }
  let(:expected_extra)  { %(\xa5\xc9) + value }

  it_should_behave_like 'argument/call'
end
