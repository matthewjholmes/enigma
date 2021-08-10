require_relative 'spec_helper'

RSpec.describe Shift do
  before :each do
    @shift = Shift.new
  end

  it '#today_generator method returns date in DDMMYY format' do
    # need mock/stub for date
    expect(@enigma.today_generator).to eq("070821")
  end

  it '#shift_generator adds keys and offsets together' do
    expected = {a_shift: 1, b_shift: 12, c_shift: 24, d_shift: 48}

    expect(@shift.shift_generator("01248", 2020-10-10)).to eq(expected)
  end

  it '#shift_rotation(shift) returns shifted character array' do
    expect(@shift.shift_rotation(:a_shift)).to be_a(Hash)
    expect(@shift.shift_rotation(:a_shift).length).to eq(27)
  end

  it '#message_char_shift_groups(message) collects characters into 4 groups according to which shift should be applied' do
    expected = [["h", "o", "r"], ["e", " ", "l"], ["l", "w", "d"], ["l", "o"]]

    expect(@shift.message_char_shift_groups("hello world")).to eq(expected)
  end
end
