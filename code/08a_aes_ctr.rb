require 'openssl'

data = "Applied Crypto.rb"

cipher = OpenSSL::Cipher.new("aes-128-ctr")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv # functions as the nonce/counter part

encrypted = cipher.update(data) + cipher.final
p encrypted
puts encrypted.size

decipher = OpenSSL::Cipher.new("aes-128-ctr")
decipher.decrypt
decipher.key = key
decipher.iv = iv

decrypted = decipher.update(encrypted) + decipher.final
p decrypted
puts decrypted == data

