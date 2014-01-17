require 'openssl'
require 'stringio'

# What happens if we forget the IV when decrypting?
# CBC mode

data = "Applied Crypto.rb" * 3

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data) + cipher.final

decipher = OpenSSL::Cipher.new("aes-128-cbc")
decipher.decrypt
decipher.key = key

decrypted = decipher.update(encrypted) + decipher.final

p decrypted

