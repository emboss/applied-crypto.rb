require 'openssl'

# Let's have a look at the padding!

data = "Applied Crypto.rb"

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data) + cipher.final
p encrypted
puts encrypted.size

decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key
decipher.iv = iv
decipher.padding = 0

decrypted = decipher.update(encrypted)
p decrypted

