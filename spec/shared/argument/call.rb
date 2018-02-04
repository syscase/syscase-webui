# frozen_string_literal: true

shared_examples 'argument/call' do
  def subject
    object.call(buffer, extra)
  end

  let(:object) { described_class.new(*args) }

  let(:buffer) { Syscase::Buffer.new }
  let(:extra)  { Syscase::Buffer.new }

  def ascii(string)
    Syscase.ascii(string)
  end

  it 'should return self' do
    expect(subject).to be object
  end

  it 'should set buffer correctly' do
    subject
    expect(buffer.to_s).to eql ascii(expected_buffer)
  end

  it 'should set extra correctly' do
    subject
    expect(extra.to_s).to eql ascii(expected_extra)
  end
end
