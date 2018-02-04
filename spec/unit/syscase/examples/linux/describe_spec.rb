# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Linux, '#compile' do
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

  let(:subject) { object.compile }

  let(:object) { Syscase::Examples::Linux.new(arg) }

  let(:arg) { File.absolute_path(path) }

  let(:root_path) { dirname(6) }

  let(:path) { File.join(root_path, 'tmp-create-linux-examples') }

  let(:fixtures) { File.join(root_path, 'spec/fixtures') }

  it 'should create linux examples' do
    subject.each do |key, example|
      expect(example.to_s).to eq Syscase.ascii(read(fixture(key)))
    end
  end
end
