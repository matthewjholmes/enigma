require_relative 'spec_helper'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
    @encryption_method_all_args = @enigma.encrypt("hello world", "02715", "060821")
    @encryption_method_string_only = @enigma.encrypt("hello world")
    @encryption_method_string_and_key = @enigma.encrypt("hello world", "02715")
    allow_any_instance_of(Enigma).to receive(:rand).and_return(12345)
  end

  describe '#initalize' do
    it 'exists' do
      expect(@enigma).to be_instance_of(Enigma)
    end
  end

  describe '#encrpyt' do
    it 'can #encrypt(message, key, date)' do
      expect(@encryption_method_all_args).to be_a(Hash)
      expect(@encryption_method_all_args).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})
    end

    it '#encrypt method takes key and date as optional' do
      # need mock/stub for key and date generation
      expect(@encryption_method_string_only).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})

      expect(@encryption_method_string_and_key).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})
    end

  end

  describe '#decrypt' do
    xit 'can #decrypt(ciphertext, key, date)' do
      expect(@enigma.decrypt("nefau qdxly", "02715", "060821")).to eq({decryption: "hello world", key: "02715", date: "060821"})
    end

    xit '#decrypt method can supply date if not provided' do
      # need mock/stub for date
      encrypted = @enigma.encrypt("hello world", "02715")
      expect(@enigma.decrypt(encrypted[:encryption], "02715")).to eq({decryption: "hello world", key: "02715", date: "060821"})
    end
  end

  describe 'helper methods (may be moved to other classes)' do


    it '#key_parser parses keys' do
      expected = {a_key: 02, b_key: 27, c_key: 71, d_key: 15}
      expect(@enigma.key_parser("02715")).to eq(expected)
    end

    it '#key_generator generates random five-digit number' do
      # mock/stub
      expect(@enigma.key_generator.length).to eq(5)
    end

    it '#character_array generates 27-char array with space' do
      expect(@enigma.character_array.length).to eq(27)
    end

    it '#offset_generator(source) generates from last four of date^2' do
      # need mock/stub for date
      # for 070821:
      supplied_date_offsets = {a_offset: 1, b_offset: 0, c_offset: 2, d_offset: 5}
      today_offsets = {a_offset: 4, b_offset: 0, c_offset: 4, d_offset: 1}
      expect(@enigma.offset_generator(:today)).to eq(today_offsets)
      expect(@enigma.offset_generator("040895")).to eq(supplied_date_offsets)
    end

  end
end
