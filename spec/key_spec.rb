require_relative 'spec_helper'

RSpec.describe Key do
  before :each do
    @key = Key.new
  end

  it '#key_parser parses keys' do
    expected = {a_key: 02, b_key: 27, c_key: 71, d_key: 15}
    expect(@key.key_parser("02715")).to eq(expected)
  end

  it '#key_generator generates random five-digit number' do

    allow_any_instance_of(Key).to receive(:rand).and_return("2715")

    expect(@key.key_generator.length).to eq(5)
    expect(@key.key_generator).to eq("02715")
  end
end
