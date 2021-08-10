require_relative 'spec_helper'
require 'date'

RSpec.describe Enigma do
  before(:each) do
    @enigma = Enigma.new
    @encryption_method_all_args = @enigma.encrypt("hello world", "02715", "060821")
    @encryption_method_string_only = @enigma.encrypt("hello world")
    @encryption_method_string_and_key = @enigma.encrypt("hello world", "02715")
  end

  describe '#initalize' do
    it 'exists' do
      expect(@enigma).to be_instance_of(Enigma)
    end
  end

  describe '#encrpyt' do
    # key and date arguments should be optional
    it 'can #encrypt(message, key, date)' do
      all_args = @enigma.encrypt("hello world", "02715", "060821")
      expect(all_args).to be_a(Hash)
      expect(all_args).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})
    end

    it '#encrypt method takes key and date as optional' do
      allow_any_instance_of(Enigma).to receive(:today).and_return(2021-6-8)

      allow_any_instance_of(Enigma).to receive(:key_generator).and_return("02715")

      expect(@enigma.encrypt("hello world")).to eq({encryption: "nefau qdxly", key: "02715", date: "060821"})
    end

    it '#text_encrypter(message) applys shifts' do
      allow_any_instance_of(Enigma).to receive(:today).and_return(2021-6-8)

      allow_any_instance_of(Enigma).to receive(:key_generator).and_return("02715")

      expect(@enigma.text_encrypter("hello world")).to eq("nefau qdxly")
    end
  end

  describe '#decrypt' do
    it 'can #decrypt(cyphertext, key, date)' do
      expect(@enigma.decrypt("nefau qdxly", "02715", "060821")).to eq({decryption: "hello world", key: "02715", date: "060821"})
    end

    it '#decrypt method can supply date if not provided' do
      # need mock/stub for date
      encrypted = @enigma.encrypt("hello world", "02715")
      expect(@enigma.decrypt(encrypted[:encryption], "02715")).to eq({decryption: "hello world", key: "02715", date: "060821"})
    end

    it '#text_decrypter(message) uses shifts to decrypt' do
      # need mock/stub for key and date generation
      expect(@enigma.text_decrypter("nefau qdxly")).to eq("hello world")
    end
  end

  describe 'helper methods (may be moved to other classes)' do
    it '#today_generator method returns date in DDMMYY format' do
      allow_any_instance_of(Enigma).to receive(:today).and_return(2021-8-9)

      expect(@enigma.today_generator).to eq("090821")
    end

    it '#key_parser parses keys' do
      expected = {a_key: 02, b_key: 27, c_key: 71, d_key: 15}
      expect(@enigma.key_parser("02715")).to eq(expected)
    end

    it '#key_generator generates random five-digit number' do
      expect(@enigma.key_generator.length).to eq(5)
    end

    it '#character_array generates 27-char array with space' do
      expect(@enigma.character_array.length).to eq(27)
    end

    it '#offset_generator(source) generates from last four of date^2' do
      supplied_date_offsets = {a_offset: 1, b_offset: 0, c_offset: 2, d_offset: 5}
      today_offsets = {a_offset: 4, b_offset: 0, c_offset: 4, d_offset: 1}
      expect(@enigma.offset_generator(:today)).to eq(today_offsets)
      expect(@enigma.offset_generator("040895")).to eq(supplied_date_offsets)
    end

    it '#shift_generator adds keys and offsets together' do
      # allow_any_instance_of(Enigma).to receive(:today_generator).and_return("070821")
      #
      # allow_any_instance_of(Enigma).to receive(:key_generator).and_return("71285")

      expected = {a_shift: 6, b_shift: 27, c_shift: 75, d_shift: 16}
      expect(@enigma.shift_generator).to eq(expected)
    end

    # it '#char_index_lookup returns index of each message char in character_array' do
    #   expected = [7, 4, 11, 11, 14, 26, 22, 14, 17, 11, 3]
    #
    #   expect(@enigma.char_lookup("hello world")).to eq(expected)
    # end

    it '#message_char_shift_groups(message) collects character  according to which shift should be applied' do
      expected = [["h", "o", "r"], ["e", " ", "l"], ["l", "w", "d"], ["l", "o"]]

      expect(@enigma.message_char_shift_groups("hello world")).to eq(expected)
    end

    it '#shift_rotation(shift) returns shifted character array' do
      # shift_1 = ["z", " ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y"]
      # shift_2 = ["n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"]

      # need mock/stub for shifts
      # a_rotation_hash = {"a"=>"i",
      #                    "b"=>"j",
      #                    "c"=>"k",
      #                    "d"=>"l",
      #                    "e"=>"m",
      #                    "f"=>"n",
      #                    "g"=>"o",
      #                    "h"=>"p",
      #                    "i"=>"q",
      #                    "j"=>"r",
      #                    "k"=>"s",
      #                    "l"=>"t",
      #                    "m"=>"u",
      #                    "n"=>"v",
      #                    "o"=>"w",
      #                    "p"=>"x",
      #                    "q"=>"y",
      #                    "r"=>"z",
      #                    "s"=>" ",
      #                    "t"=>"a",
      #                    "u"=>"b",
      #                    "v"=>"c",
      #                    "w"=>"d",
      #                    "x"=>"e",
      #                    "y"=>"f",
      #                    "z"=>"g",
      #                    " "=>"h"}

      expect(@enigma.shift_rotation(:a_shift)).to be_a(Hash)
      expect(@enigma.shift_rotation(:a_shift).length).to eq(27)
    end
  end
end
