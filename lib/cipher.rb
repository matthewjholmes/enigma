require_relative 'generatable'

class Cipher
  include Generatable

  def initialize
    @key = key_generator
    @date = today_generator
  end

  def self.cipher_translation(text, key = @key, date = @date, direction)
    output_hash = {}
    output_text = cipher_renderer(text, direction)
    if direction == :encrypt
      output_hash = {encryption: output_text, key: key, date: date}
    else
      output_hash == {decryption: output_text, key: key, date: date}
    end
    output_hash
  end

  def self.cipher_renderer(message, direction)
    a = message_char_shift_groups(message)[0].map do |char|
      shift_rotation(:a_shift, direction).fetch(char, char)
    end
    b = message_char_shift_groups(message)[1].map do |char|
      shift_rotation(:b_shift, direction).fetch(char, char)
    end
    c = message_char_shift_groups(message)[2].map do |char|
      shift_rotation(:c_shift, direction).fetch(char, char)
    end
    d = message_char_shift_groups(message)[3].map do |char|
      shift_rotation(:d_shift, direction).fetch(char, char)
    end
    ordered_array = a.zip(b, c, d)
    unified_array = ordered_array.flatten.compact
    unified_array.join
  end
end
