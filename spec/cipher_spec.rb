require_relative 'spec_helper'

RSpec.describe Cipher do
  before(:each) do
    @cipher = Cipher.new
  end

  it 'exists' do
    expect(@cipher).to be_instance_of(Enigma)
  end



  it '#cipher_renderer(message, direction) applys shifts' do
    # need mock/stub for key and date generation
    expect(@cipher.cipher_renderer("hello world", :encrypt)).to eq("nefau qdxly")
    expect(@cipher.cipher_renderer("nefau qdxly", :decrypt)).to eq("hello world")
  end
end
