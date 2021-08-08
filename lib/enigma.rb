class Enigma

  attr_reader :key, :date

  def initialize
    @key = key_generator
    @date = today_generator
  end

  def encrypt(message, key = key_generator, date = today_generator)
    @key = key
    @date = date

    hash = Hash.new
    # t = message.split("")

    # e = t.each_slice(4).map do |letter|
    #   letter.upcase
    # end
    # e = t.values_at
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
    t = {a_shift: a, b_shift: b, c_shift: c, d_shift: d}
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

  def alphabet_array
    ("a".."z").to_a << " "
  end

  def char_index_lookup(message)
    message_arry = message.split("")
    message_arry.map do |char|
      alphabet_array.index(char)
    end
  end

  def message_char_shift_groups(message)
    index_arry = char_index_lookup(message)
    hash = Hash.new([])
    t = index_arry.each_with_index do |index, char_position|
      if index.index(char_position) % 4 == 0
        hash[:a] ||= [char_position]
        hash[:a] << [char_position]
      elsif index.index(char_position) % 4 == 1
        hash[:b] ||= [char_position]
        hash[:b] << [char_position]
      elsif index.index(char_position) % 4 == 2
        hash[:c] ||= [char_position]
        hash[:c] << [char_position]
      elsif index.index(char_position) % 4 == 3
        hash[:d] ||= [char_position]
        hash[:d] << [char_position]
      end
    end
    hash
    require "pry"; binding.pry
    # a = index_arry.each_with_index.group_by do |char_position, index|
    #   # char_position.each do |
    #   # % 4 == 0
    #   require "pry"; binding.pry
    # end
    # b = index_arry.find_all do |char_position|
    #   index_arry.index(char_position) % 4 == 1
    # end
    # c = index_arry.find_all do |char_position|
    #   index_arry.index(char_position) % 4 == 2
    # end
    # d = index_arry.find_all do |char_position|
    #   require "pry"; binding.pry
    #   index_arry.index(char_position) % 4 == 3
    # end

  end

  # find char index for knowing which shift to apply
  #shift and get new index position


  # find within charcter array the index position of each character in message
  # with_index
  # each_with_index


end
