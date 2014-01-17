require 'openssl'
require 'securerandom'

# cf. http://www.ruby-doc.org/stdlib-2.1.0/libdoc/openssl/rdoc/OpenSSL/Cipher.html

cipher = OpenSSL::Cipher.new("aes-128-cbc")
cipher.encrypt # more on that later

key = SecureRandom.random_bytes(cipher.key_len)
iv = SecureRandom.random_bytes(cipher.block_size)

p key
puts (key.size * 8)

p iv
puts (iv.size)
