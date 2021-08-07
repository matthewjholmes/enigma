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
    t = ("a".."z").to_a << " "
  end

  def message_parser(string)
    message_arry = string.split("")
    t = message_arry.select do |char|
      index(char) % 4 == 0
    end
    require "pry"; binding.pry
  end
end
