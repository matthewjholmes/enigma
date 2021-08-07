require_relative 'spec_helper'
require 'date'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
  end

  describe '#initalize' do
    it 'exists' do
      expect(@enigma).to be_instance_of(Enigma)
    end
  end

  describe '#encrpyt' do
    # key and date arguments should be optional
    xit 'can #encrypt(message, key, date)' do
      expect(@enigma.encrypt("hello world", "02715", "060821")).to be_a(Hash)
      expect(@enigma.encrypt("hello", "02715", "060821")).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})
    end

    xit '#encrypt method takes key and date as optional' do
      # need mock/stub for key and date generation
      expect(@enigma.encrypt("hello world")).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})

      expect(@enigma.encrypt("hello world", "02715")).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})
    end
  end

  describe '#decrypt' do
    xit 'can #decrypt(cyphertext, key, date)' do
      expect(@enigma.decrypt("nefau qdxly", "02715", "060821")).to eq({decryption: "hello world", key: "02715", date: "060821"})
    end

    xit '#decrypt method can supply date if not provided' do
      # need mock/stub for date
      encrypted = enigma.encrypt("hello world", "02715")
      expect(@enigma.decrypt(encrypted[:encryption], "02715")).to eq({decryption: "hello world", key: "02715", date: "060821"})
    end
  end

  describe 'helper methods (may be moved to other classes)' do
    it '#today_generator method returns date in DDMMYY format' do
      # need mock/stub for date
      expect(@enigma.today_generator).to eq("070821")
    end

    it '#key_parser parses keys' do
      expect(@enigma.key_parser("02715")).to eq({a_key: 02, b_key: 27, c_key: 71, d_key: 15})
    end

    it '#key_generator generates random five-digit number' do
      # mock/stub
      expect(@enigma.key_generator.length).to eq(5)
    end

    it '#alphabet_array generates 27-char array with space' do
      expect(@enigma.alphabet_array.length).to eq(27)
    end

    it '#offset_generator generates from last four of date^2' do
      # need mock/stub for date
      # for 070821:
      expected = {a_offset: 4, b_offset: 0, c_offset: 4, d_offset: 1}
      expect(@enigma.offset_generator).to eq(expected)
    end
  end
end
