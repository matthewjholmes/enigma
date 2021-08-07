require_relative 'spec_helper'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end

  it 'exists' do
    expect(@engima).to be_a(Enigma)
  end 
end
