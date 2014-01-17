require_relative 'cryptor'

data = "Applied Crypto.rb"

cipher = Encryptor.new("aes-128-cbc")

encrypted = cipher.encrypt(data)

decipher = Decryptor.new("aes-128-cbc", key: cipher.key, iv: cipher.iv)

decrypted = decipher.decrypt(encrypted)

puts decrypted
puts decrypted == data
