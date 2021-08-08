class Enigma

  attr_reader :key, :date

  def initialize
    @key = key_generator
    @date = today_generator
  end

  def encrypt(message, key = key_generator, date = today_generator)
    @key = key
    @date = date
    encryption_text = letter_encrypter(message)
    {encryption: encryption_text, key: @key, date: @date}
  end

  def letter_encrypter(message)
    a = message_char_shift_groups(message)[0].map do |letter_index|
      shift_rotation[:a_rotation][letter_index]
    end
    b = message_char_shift_groups(message)[1].map do |letter_index|
      shift_rotation[:b_rotation][letter_index]
    end
    c = message_char_shift_groups(message)[2].map do |letter_index|
      shift_rotation[:c_rotation][letter_index]
    end
    d = message_char_shift_groups(message)[3].map do |letter_index|
      shift_rotation[:d_rotation][letter_index]
    end
    ordered_array = a.zip(b, c, d)
    unified_array = ordered_array.flatten.compact
    encryption_text = unified_array.join
  end

  def offset_generator(source)
    if source == :today
      date = today_generator
    else
      date = source
    end
    square = date.to_i ** 2
    offset = square.to_s
    a = offset[-4].to_i
    b = offset[-3].to_i
    c = offset[-2].to_i
    d = offset[-1].to_i
    {a_offset: a, b_offset: b, c_offset: c, d_offset: d}
  end

  def shift_generator
    a = offset_generator(@date)[:a_offset] + key_parser(@key)[:a_key]
    b = offset_generator(@date)[:b_offset] + key_parser(@key)[:b_key]
    c = offset_generator(@date)[:c_offset] + key_parser(@key)[:c_key]
    d = offset_generator(@date)[:d_offset] + key_parser(@key)[:d_key]
    {a_shift: a, b_shift: b, c_shift: c, d_shift: d}
  end

  def today_generator
    Date.today.strftime("%d%m%y").to_s
  end

  def key_parser(key)
    a = key[0..1].to_i
    b = key[1..2].to_i
    c = key[2..3].to_i
    d = key[3..4].to_i
    {a_key: a, b_key: b, c_key: c, d_key: d}
  end

  def key_generator
    random = rand(1..99999)
    '%05d' % random
  end

  def character_array
    ("a".."z").to_a << " "
  end

  def char_index_lookup(message)
    message_arry = message.split("")
    message_arry.map do |char|
      character_array.index(char)
    end
  end

  def message_char_shift_groups(message)
    index_arry = char_index_lookup(message)
    shift_groups = [[],[],[],[]]
    # shift_groups = {a_indices: [],
    #                 b_indices: [],
    #                 c_indices: [],
    #                 d_indices: []}
    d_group_length = shift_groups[3].length
    max_group_length = index_arry.length % 4
    index_arry.each_with_index do |num, index|
      if index % 4 == 0
        shift_groups[0] << num
      elsif index % 4 == 1
        shift_groups[1] << num
      elsif index % 4 == 2
        shift_groups[2] << num
      elsif index % 4 == 3
        shift_groups[3] << num
      end
      break if d_group_length == max_group_length
    end
    shift_groups
  end

  def shift_rotation
    a = character_array.rotate(shift_generator[:a_shift])
    b = character_array.rotate(shift_generator[:b_shift])
    c = character_array.rotate(shift_generator[:c_shift])
    d = character_array.rotate(shift_generator[:d_shift])
    {a_rotation: a, b_rotation: b, c_rotation: c, d_rotation: d}
  end
  # find char index for knowing which shift to apply
  #shift and get new index position


  # find within charcter array the index position of each character in message
  # with_index
  # each_with_index

# e = t.values_at

end
