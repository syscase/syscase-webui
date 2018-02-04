# frozen_string_literal: true

require 'spec_helper'

describe 'create linux examples' do
  let(:root_path) { File.dirname(File.dirname(File.dirname(__FILE__))) }

  let(:path) { File.join(root_path, 'tmp-create-linux-examples') }
  let(:fixtures) { File.join(root_path, 'spec/fixtures') }

  def fixture(key)
    File.join(fixtures, key.to_s)
  end

  def tmp(key)
    File.join(path, key.to_s)
  end

  def read(file)
    IO.read(file)
  end

  it 'should work' do
    FileUtils.mkdir_p path
    examples = Syscase::Examples::Linux.new(File.absolute_path(path))
    examples.write
    examples.describe.each_key do |key|
      t = tmp(key)
      expect(read(t)).to eq read(fixture(key))
      FileUtils.rm t
    end
    FileUtils.rmdir path
  end
end
