require 'openssl'

# What happens if we forget the call to Cipher#final?

data = "1234567890123456" # exactly 16 bytes long

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data) # + cipher.final
p encrypted
puts encrypted.size

decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key
decipher.iv = iv
decipher.padding = 0

decrypted = decipher.update(encrypted)
puts decrypted
puts decrypted == data

