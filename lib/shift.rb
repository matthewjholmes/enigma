require_relative 'generatable'

class Shift

  include Generatable

  def initialize
    @key = key_generator
    @date = today_generator
  end

  def shift_generator(key = @key, date = @date)
    a = offset_generator(date)[:a_offset] + key_parser(key)[:a_key]
    b = offset_generator(date)[:b_offset] + key_parser(key)[:b_key]
    c = offset_generator(date)[:c_offset] + key_parser(key)[:c_key]
    d = offset_generator(date)[:d_offset] + key_parser(key)[:d_key]
    {a_shift: a, b_shift: b, c_shift: c, d_shift: d}
  end

  def shift_rotation(shift, direction = :encrypt)
      rotated_array = character_array_generator.rotate(shift_generator[shift])
      rotation_hash = character_array_generator.zip(rotated_array).to_h
      if direction == :decrypt
        rotation_hash.invert
      else
        rotation_hash
      end
  end

  def message_char_shift_groups(message)
    message_arry = message.downcase.split("")
    shift_groups = [[],[],[],[]]
    d_group_length = shift_groups[3].length
    max_group_length = message_arry.length % 4
    message_arry.each_with_index do |char, index|
      if index % 4 == 0
        shift_groups[0] << char
      elsif index % 4 == 1
        shift_groups[1] << char
      elsif index % 4 == 2
        shift_groups[2] << char
      elsif index % 4 == 3
        shift_groups[3] << char
      end
      break if d_group_length == max_group_length
    end
    shift_groups
  end
end
