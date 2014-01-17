require 'openssl'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

data = "Applied Crypto.rb"

cipher = OpenSSL::Cipher.new("aes-128-gcm")
cipher.encrypt
key = cipher.random_key
iv = cipher.random_iv
cipher.auth_data = "" # unfortunately this is currently needed

encrypted = cipher.update(data) + cipher.final
tag = cipher.auth_tag

puts encrypted.size # => it's effectifely a stream cipher like CTR mode
p tag
puts tag.size

decipher = OpenSSL::Cipher.new("aes-128-gcm")
decipher.decrypt
decipher.key = key
decipher.iv = iv
decipher.auth_tag = tag # must be set before decryption is executed
decipher.auth_data = ""

plain = decipher.update(encrypted) + decipher.final

puts data == plain
