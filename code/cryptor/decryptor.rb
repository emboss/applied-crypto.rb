require_relative 'cryptor'

class Decryptor < Cryptor

  def initialize(algo, key:, iv:, padding: true)
    @cipher = OpenSSL::Cipher.new(algo)
    @cipher.decrypt
    @key = key
    @iv = iv
    @cipher.key = @key
    @cipher.iv = @iv
    @cipher.padding = 0 unless padding
  end

  def decrypt(ciphertext)
    @cipher.update(ciphertext) << @cipher.final
  end

end
