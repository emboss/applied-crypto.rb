require 'openssl'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

data = "Martin Boßlet"

p data
puts data.size
puts data.bytesize

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
p decrypted
puts decrypted == data

puts data.encoding
puts decrypted.encoding
puts data.size
puts decrypted.size

decrypted.force_encoding(data.encoding)
puts decrypted.encoding
puts decrypted.size

puts decrypted == data
