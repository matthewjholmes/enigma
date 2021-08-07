class Enigma

  def initialize
    @key = 02715

  end

  def encrypt(message, key = @key, date = today_generator )
  end

  def today_generator
    Date.today.strftime("%d%m%y").to_s
  end
end
