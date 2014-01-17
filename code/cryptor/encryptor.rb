require_relative 'cryptor'

class Encryptor < Cryptor

  def initialize(algo, key: nil, iv: nil, padding: true)
    @cipher = OpenSSL::Cipher.new(algo)
    @cipher.encrypt
    set_random(:key, key)
    set_random(:iv, iv)
    @cipher.padding = 0 unless padding
  end

  def encrypt(msg)
    @cipher.update(msg) << @cipher.final
  end

  private

  def set_random(name, value)
    if value
      @cipher.send("#{name}=", value)
    else
      value = @cipher.send("random_#{name}")
    end
    instance_variable_set("@#{name}", value)
  end

end
