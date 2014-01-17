require 'openssl'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

data = "Applied Crypto.rb"
puts data.size

cipher = OpenSSL::Cipher.new("rc4")
cipher.encrypt

key = cipher.random_key
# no IV

encrypted = cipher.update(data)
p encrypted
puts encrypted.size

decipher = OpenSSL::Cipher.new("rc4")
decipher.decrypt
decipher.key = key

decrypted = decipher.update(encrypted)
puts decrypted
puts decrypted == data

