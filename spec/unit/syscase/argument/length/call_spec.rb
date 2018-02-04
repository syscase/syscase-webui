# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Argument::Length, '#call' do
  let(:args) { [] }

  let(:expected_buffer) { %(\x03) }
  let(:expected_extra)  { %() }

  it_should_behave_like 'argument/call'
end
