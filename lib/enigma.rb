class Enigma

  def initialize

  end

  def encrypt(message, key = @key_generator, date = today_generator)
    
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
end
