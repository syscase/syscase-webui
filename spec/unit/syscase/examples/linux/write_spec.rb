# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Linux, '#write' do
  def dirname(n)
    dir = __FILE__
    n.times do
      dir = File.dirname(dir)
    end
    dir
  end

  def fixture(key)
    File.join(fixtures, key.to_s)
  end

  def tmp(key)
    File.join(path, key.to_s)
  end

  def read(file)
    IO.read(file)
  end

  let(:subject) { object.write }

  let(:object) { described_class.new(arg) }

  let(:arg) { File.absolute_path(path) }

  let(:root_path) { dirname(6) }

  let(:path) { File.join(root_path, 'tmp-create-linux-examples') }

  let(:fixtures) { File.join(root_path, 'spec/fixtures') }

  let(:examples) { object.examples }

  let(:result) { 42 }

  let(:expected_result) do
    array = []
    7.times { array << result }
    array
  end

  before :each do
    allow(IO).to receive(:write) { result }
  end

  it 'should create linux examples' do
    examples.each do |key, example|
      expected = Syscase.ascii(read(fixture(key)))
      expect(IO).to receive(:write).with(tmp(key), expected)
      example.compile.write_example
    end
  end

  it 'should return length written' do
    expect(subject.values).to match_array(expected_result)
  end
end
