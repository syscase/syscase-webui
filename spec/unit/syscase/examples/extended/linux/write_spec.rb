# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Extended::Linux, '#write' do
  def dirname(n)
    dir = __FILE__
    n.times do
      dir = File.dirname(dir)
    end
    dir
  end

  def tmp(name)
    File.join(output_path, name)
  end

  let(:subject) { object.write }

  let(:object) { described_class.new(input_path, output_path) }

  let(:output_path) { File.absolute_path(path) }
  let(:input_path) { File.absolute_path(examples_path) }

  let(:examples_path) do
    File.join(root_path, 'spec/fixtures/linux_examples.txt')
  end

  let(:root_path) { dirname(6) }

  let(:path) { File.join(root_path, 'tmp-create-linux-examples-extended') }

  let(:input) do
    <<~INPUT
      fd
      fd, buffer
    INPUT
  end

  let(:result) { 42 }

  let(:expected_result) do
    {
      'call000-0': 42,
      'call000-1': 42,
      'call000-2': 42,
      'call000-3': 42,
      'call001-0': 42,
      'call001-1': 42,
      'call001-2': 42,
      'call001-3': 42
    }
  end

  let(:'call000-0') do
    # Call 0
    %(\x00\x00) +
      # fd 1
      %(\x05\x00\x01) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00)
  end

  let(:'call000-1') do
    # Call 0
    %(\x00\x00) +
      # File
      %(\x04) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # Extra String
      %(\xA5\xC9testing)
  end

  let(:'call000-2') do
    # Call 0
    %(\x00\x00) +
      # fd 1
      %(\x05\x00\x01) +
      # Alloc
      %(\x01\x00\x00\x00\x08) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00)
  end

  let(:'call000-3') do
    # Call 0
    %(\x00\x00) +
      # File
      %(\x04) +
      # Alloc
      %(\x01\x00\x00\x00\x08) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # Extra String
      %(\xA5\xC9testing)
  end

  let(:'call001-0') do
    # Call 1
    %(\x00\x01) +
      # fd 1
      %(\x05\x00\x01) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00)
  end

  let(:'call001-1') do
    # Call 1
    %(\x00\x01) +
      # File
      %(\x04) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # Extra String
      %(\xA5\xC9testing)
  end

  let(:'call001-2') do
    # Call 1
    %(\x00\x01) +
      # fd 1
      %(\x05\x00\x01) +
      # Alloc
      %(\x01\x00\x00\x00\x08) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00)
  end

  let(:'call001-3') do
    # Call 0
    %(\x00\x01) +
      # File
      %(\x04) +
      # Alloc
      %(\x01\x00\x00\x00\x08) +
      # Padding 0
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      %(\x00\x00\x00\x00\x00\x00\x00\x00\x00) +
      # Extra String
      %(\xA5\xC9testing)
  end

  before :each do
    allow(IO).to receive(:read) { input }
    allow(IO).to receive(:write) { result }
    object.instance_variable_set(:@range, (0..1))
  end

  it 'should write string' do
    expected_result.each_key do |key|
      expect(IO).to receive(:write).with(
        tmp(key.to_s),
        Syscase.ascii(method(key).call)
      ).once
    end

    expect(subject).to eq expected_result
  end
end
