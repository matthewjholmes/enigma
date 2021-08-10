require_relative 'cipher'

class Enigma
  include Generatable

  def encrypt(message, key = key_generator, date = today_generator)
    # key = key
    # date = date
    cipher.cipher_hash_package(message, key, date, :encrypt)
  end

  def decrypt(ciphertext, key, date = today_generator)
    # key = key
    # date = date
    cipher.cipher_hash_package(message, key, date, :decrypt)
  end
end
