# frozen_string_literal: true

require 'spec_helper'

describe Syscase::Examples::Extended::Linux, '#parse_argument' do
  def dirname(n)
    dir = __FILE__
    n.times do
      dir = File.dirname(dir)
    end
    dir
  end

  let(:subject) { object.send(:parse_argument, arg, test) }

  let(:object) { described_class.new(input_path, output_path) }

  let(:test) { object.tests[0] }

  let(:output_path) { File.absolute_path(path) }
  let(:input_path) { File.absolute_path(examples_path) }

  let(:examples_path) do
    File.join(root_path, 'spec/fixtures/linux_examples.txt')
  end

  let(:root_path) { dirname(6) }

  let(:path) { File.join(root_path, 'tmp-create-linux-examples-extended') }

  let(:input) { double('input') }

  let(:arg) { 'fd' }

  before :each do
    allow(IO).to receive(:read) { input }
  end

  it 'should return file descriptor for argument "fd" with test 0' do
    expect(subject).to be_a(Syscase::Argument::FileDescriptor)
  end

  context 'with test 1' do
    let(:test) { object.tests[1] }

    it 'should return file for argument "fd"' do
      expect(subject).to be_a(Syscase::Argument::String::File)
    end

    context 'with arg = "buffer"' do
      let(:arg) { 'buffer' }

      it 'should return buffer for argument "buffer"' do
        expect(subject).to be_a(Syscase::Argument::Alloc)
      end
    end

    context 'with arg = "filename"' do
      let(:arg) { 'filename' }

      it 'should return filename for argument "filename"' do
        expect(subject).to be_a(Syscase::Argument::String::Filename)
      end
    end

    context 'with arg = "int"' do
      let(:arg) { 'int' }

      it 'should return integer for argument "int"' do
        expect(subject).to be 0
      end
    end

    context 'with arg = "ptr"' do
      let(:arg) { 'ptr' }

      it 'should return ptr for argument "ptr"' do
        expect(subject).to be_a(Syscase::Argument::Alloc)
      end
    end

    context 'with arg = "signalno"' do
      let(:arg) { 'signalno' }

      it 'should return signalno for argument "signalno"' do
        expect(subject).to be 0
      end
    end

    context 'with arg = "string"' do
      let(:arg) { 'string' }

      it 'should return string for argument "string"' do
        expect(subject).to eq Syscase.ascii(%(12345678))
      end
    end

    context 'with arg = "len"' do
      let(:arg) { 'len' }

      it 'should return length for argument "len"' do
        expect(subject).to be_a(Syscase::Argument::Length)
      end
    end

    context 'with arg = "unknown"' do
      let(:arg) { 'unknown' }

      it 'should return default for unknown argument' do
        expect(subject).to be object.default
        expect(object.default).to be_a(Syscase::Argument::Alloc)
      end
    end
  end
end
