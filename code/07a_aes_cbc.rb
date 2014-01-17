require 'openssl'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

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

decrypted = decipher.update(encrypted) + decipher.final
puts decrypted
puts decrypted == data

