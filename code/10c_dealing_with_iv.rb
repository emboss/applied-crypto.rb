require 'openssl'
require 'stringio'

# What happens if we forget the IV when decrypting?
# Streaming mode like CTR

data = "Applied Crypto.rb" * 3

cipher = OpenSSL::Cipher.new("aes-128-ctr")
cipher.encrypt

key = cipher.random_key
iv = cipher.random_iv

encrypted = cipher.update(data) + cipher.final

decipher = OpenSSL::Cipher.new("aes-128-ctr")
decipher.decrypt
decipher.key = key

decrypted = decipher.update(encrypted) + decipher.final

p decrypted

